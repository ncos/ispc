#!/usr/bin/python
#
#  Copyright (c) 2014, Intel Corporation 
#  All rights reserved.
# 
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are
#  met:
# 
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
# 
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
# 
#    * Neither the name of Intel Corporation nor the names of its
#      contributors may be used to endorse or promote products derived from
#      this software without specific prior written permission.
# 
# 
#   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
#   IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
#   TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
#   PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
#   OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#   PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# // Authors: Anton Mitrokhin, Vsevolod Livinskiy



def uniq(lst):
    last = object()
    for item in lst:
        if item == last:
            continue
        yield item
        last = item

def sort_and_deduplicate(l):
    return list(uniq(sorted(l, reverse=True)))

class DictDiffer(object):
    """
    Calculate the difference between two dictionaries as:
    (1) items added
    (2) items removed
    (3) keys same in both but changed values
    (4) keys same in both and unchanged values
    """
    def __init__(self, current_dict, past_dict):
        self.current_dict, self.past_dict = current_dict, past_dict
        self.set_current, self.set_past = set(current_dict.keys()), set(past_dict.keys())
        self.intersect = self.set_current.intersection(self.set_past)
    def added(self):
        return self.set_current - self.intersect 
    def removed(self):
        return self.set_past - self.intersect 
    def changed(self):
        return set(o for o in self.intersect if self.past_dict[o] != self.current_dict[o])
    def unchanged(self):
        return set(o for o in self.intersect if self.past_dict[o] == self.current_dict[o])


class Test(object):
    def __init__(self, name_, runfailed_, compfailed_, skipped_):
        self.name = name_
        self.runfailed = runfailed_
        self.compfailed = compfailed_
        self.skipped = skipped_

    def __repr__(self):
        # Default printout function
        return "%s(%d %d %d)" % (self.name, self.runfailed, self.compfailed, self.skipped)
    
    def __eq__(self, other):
        if isinstance(other, Test):
            if self.name == other.name             and \
               self.runfailed == other.runfailed   and \
               self.compfailed == other.compfailed and \
               self.skipped == other.skipped:
                return True
            else:
                return False
        return NotImplemented

    def __ne__(self, other):
        result = self.__eq__(other)
        if result is NotImplemented:
            return result
        return not result
        

class TestTable(object):
    def __init__(self):
        self.table = {}

    def add_arch(self, arch):
        if arch not in self.table:
            self.table[arch] = {}

    def add_optimization(self, arch, optimization):
        self.add_arch(arch)
        if optimization not in self.table[arch]:
            self.table[arch][optimization] = {}
    
    def add_target(self, arch, optimization, target):
        self.add_optimization(arch, optimization)
        if target not in self.table[arch][optimization]:
            self.table[arch][optimization][target] = []
    
    def add(self, test, arch, optimization, target):
        self.add_target(arch, optimization, target)
        if not test in self.table[arch][optimization][target]:
            self.table[arch][optimization][target].append(test)
            return True
        return False
    
    def __sub__(self, other):
        pass

    def __repr__(self):
        str = ""
        archs = self.table.keys()
        for arch in archs:
            optimizations = self.table[arch].keys()
            for optimization in optimizations:
                targets = self.table[arch][optimization].keys()
                for target in targets:
                    str = str + arch + "|" + optimization + "|" + target + "|  \n"
                    for test_ in self.table[arch][optimization][target]:
                        if test_.runfailed + test_.compfailed + test_.skipped != 0:
                            str = str + repr(test_).rjust(70) + "\n"
        return str


class ExecutionStatGatherer(object):
    def __init__(self):

        self.tests_total     = 0
        self.tests_completed = 0
        self.tests_skipped   = 0
        self.tests_comperr   = 0
        self.tests_failed    = 0
        self.tests_succeed   = 0

        self.revision        = "" 
        self.test_table = TestTable()
       
    def add_test_result(self, test, arch, optimization, target):
        self.test_table.add(test, arch, optimization, target)
        self.tests_completed += 1
        self.tests_skipped += test.skipped
        self.tests_comperr += test.compfailed
        self.tests_failed += test.runfailed
        if (test.skipped + test.compfailed + test.runfailed == 0):
            self.tests_succeed += 1

    def __repr__(self):
        str = ""
        str = str + ("ESG: Revision of LLVM %s\n" % (self.revision))
        str = str + ("ESG: Done %d / %d\n" % (self.tests_completed, self.tests_total))
        str = str + ("ESG: %d / %d tests SKIPPED\n" % (self.tests_skipped, self.tests_total))
        str = str + ("ESG: %d / %d tests FAILED compilation\n" % (self.tests_comperr, self.tests_total))
        str = str + ("ESG: %d / %d tests FAILED execution\n" % (self.tests_failed, self.tests_total))
        str = str + ("ESG: Passed %d / %d\n" % (self.tests_succeed, self.tests_total))
        str = str + "\n"
        str = str + repr(self.test_table)
        return str
    
    
    def __sub__(self, other):
        result = ExecutionStatGatherer()
        result.test_table   = self.test_table - other.test_table
        result.revision     = str(int(self.revision) - int(other.revision))
        result.tests_total  = max (self.tests_total, other.tests_total)
        result.tests_completed  = self.tests_completed - other.tests_completed
        result.tests_skipped    = self.tests_skipped - other.tests_skipped
        result.tests_comperr    = self.tests_comperr - other.tests_comperr
        result.tests_failed     = self.tests_failed - other.tests_failed
        result.tests_succeed    = self.tests_succeed - other.tests_succeed
        return result

    def diff (self, esg_b):
        ret = ExecutionStatGatherer()
        arch_diff =  DictDiffer(self.test_table.table, esg_b.test_table.table)
        for i in arch_diff.added():
            ret.test_table.add_arch(i)
            ret.test_table.table[i] = self.test_table.table[i]
        for arch in arch_diff.changed():
            ret.test_table.add_arch(arch)
            opt_diff =  DictDiffer(self.test_table.table[arch], esg_b.test_table.table[arch])
            for i in opt_diff.added():
                ret.test_table.add_optimization(arch, i)
                ret.test_table.table[arch][i] = self.test_table.table[arch][i]
            for opt in opt_diff.changed():
                ret.test_table.add_optimization(arch, opt)
                target_diff =  DictDiffer(self.test_table.table[arch][opt], esg_b.test_table.table[arch][opt])
                for i in target_diff.added():
                    ret.test_table.add_target(arch, opt, i)
                    ret.test_table.table[arch][opt][i] = self.test_table.table[arch][opt][i]
                for target in target_diff.changed():
                    ret.test_table.add_target(arch, opt, target)
                    #TODO: fix uniq function to work properly
                    #ret.test_table.table[arch][opt][target] = list(set(self.test_table.table[arch][opt][target]) \
                    #                                 .difference(set(esg_b.test_table.table[arch][opt][target])))
                    ret.test_table.table[arch][opt][target] = uniq(self.test_table.table[arch][opt][target] + \
                                                                   esg_b.test_table.table[arch][opt][target])
        ret.revision = str(int(self.revision) - int(esg_b.revision))
        ret.tests_total = max (self.tests_total, esg_b.tests_total)
        ret.tests_completed = self.tests_completed - esg_b.tests_completed
        ret.tests_skipped = self.tests_skipped - esg_b.tests_skipped
        ret.tests_comperr = self.tests_comperr - esg_b.tests_comperr
        ret.tests_failed = self.tests_failed - esg_b.tests_failed
        ret.tests_succeed = self.tests_succeed - esg_b.tests_succeed
        return ret

    def find_worst_test(self):
        run_fail      = 0
        comp_fail     = 0
        str_run_fail  = ""
        str_comp_fail = ""
        archs = self.test_table.table.keys()
        for arch in archs:
            optimizations = self.test_table.table[arch].keys()
            for optimization in optimizations:
                targets = self.test_table.table[arch][optimization].keys()
                for target in targets:
                    for test_ in self.test_table.table[arch][optimization][target]:
                        if test_.runfailed > run_fail:
                            run_fail = test_.runfailed
                            str_run_fail = arch + " " + optimization + " " + target
                        if test_.compfailed > comp_fail:
                            comp_fail = test_.compfailed
                            str_comp_fail = arch + " " + optimization + " " + target
        return [str_run_fail, str_comp_fail] 
        

