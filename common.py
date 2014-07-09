#!/usr/bin/python
#
#  Copyright (c) 2013, Intel Corporation 
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

# // Author: Filippov Ilia
import sys
import os
import errno
import shutil

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

class Test:
    def __init__(self, name_, runfailed_, compfailed_, skipped_):
        self.name = name_
        self.runfailed = runfailed_
        self.compfailed = compfailed_
        self.skipped = skipped_

    def __repr__(self):
        # Default printout function
        return "%s(%d %d %d)" % (self.name, self.runfailed, self.compfailed, self.skipped)


class TestTable:
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


class ExecutionStatGatherer:
    def __init__(self):

        self.tests_total     = 0
        self.tests_completed = 0
        self.tests_skipped   = 0
        self.tests_comperr   = 0
        self.tests_failed    = 0
        self.tests_succeed   = 0

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
        str = str + ("ESG: Done %d / %d\n" % (self.tests_completed, self.tests_total))
        str = str + ("ESG: %d / %d tests SKIPPED\n" % (self.tests_skipped, self.tests_total))
        str = str + ("ESG: %d / %d tests FAILED compilation\n" % (self.tests_comperr, self.tests_total))
        str = str + ("ESG: %d / %d tests FAILED execution\n" % (self.tests_failed, self.tests_total))
        str = str + ("ESG: Passed %d / %d\n" % (self.tests_succeed, self.tests_total))
        str = str + "\n"
        str = str + repr(self.test_table)
        return str

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
                    ret.test_table.add_target(arch,opt, i)
                    ret.test_table.table[arch][opt][i] = self.test_table.table[arch][opt][i]
                for target in target_diff.changed():
                    ret.test_table.add_target(arch,opt, target)
                    ret.test_table.table[arch][opt][target] = list(set(self.test_table.table[arch][opt][target]).difference( (esg_b.test_table.table[arch][opt][target])))
        ret.tests_total = max (self.tests_total, esg_b.tests_total)
        ret.tests_completed = self.tests_completed - esg_b.tests_completed
        ret.tests_skipped = self.tests_skipped - esg_b.tests_skipped
        ret.tests_comperr = self.tests_comperr - esg_b.tests_comperr
        ret.tests_failed = self.tests_failed - esg_b.tests_failed
        ret.tests_succeed = self.tests_succeed - esg_b.tests_succeed        
        return ret


ex_state = ExecutionStatGatherer() 

def write_to_file(filename, line):
    f = open(filename, 'a')
    f.writelines(line)
    f.close()

#remove file if it exists
def remove_if_exists(filename):
    if os.path.exists(filename):
        if os.path.isdir(filename):
            shutil.rmtree(filename)
        else:
            os.remove(filename)

def make_sure_dir_exists(path):
    try:
        os.makedirs(path)
    except OSError as exception:
        if exception.errno != errno.EEXIST:
            raise


# detect version which is printed after command
def take_lines(command, which):
    os.system(command + " > " + "temp_detect_version")
    version = open("temp_detect_version")
    if which == "first":
        answer = version.readline()
    if which == "all":
        answer = version.readlines()
    version.close()
    remove_if_exists("temp_detect_version")
    return answer

# print versions of compilers
def print_version(ispc_test, ispc_ref, ref_compiler, s, perf_log, is_windows):
    print_debug("\nUsing test compiler: " + take_lines(ispc_test + " --version", "first"), s, perf_log)
    if ispc_ref != "":
        print_debug("Using ref compiler:  " + take_lines(ispc_ref + " --version", "first"), s, perf_log)
    if is_windows == False:
        temp1 = take_lines(ref_compiler + " --version", "first")
    else:
        os.system(ref_compiler + " 2>&1" + " 2> temp_detect_version > temp_detect_version1" )
        version = open("temp_detect_version")
        temp1 = version.readline()
        version.close()
        remove_if_exists("temp_detect_version")
        remove_if_exists("temp_detect_version1")
    print_debug("Using C/C++ compiler: " + temp1 + "\n", s, perf_log)

# print everything from scripts instead errors
def print_debug(line, silent, filename):
    if silent == False:
        sys.stdout.write(line)
        sys.stdout.flush()
        if os.environ.get("ISPC_HOME") != None:
            if os.path.exists(os.environ.get("ISPC_HOME")):
                write_to_file(os.environ["ISPC_HOME"] + os.sep + "notify_log.log", line)
    if filename != "":
        write_to_file(filename, line)

# print errors from scripts
# type 1 for error in environment
# type 2 for warning
# type 3 for error of compiler or test which isn't the goal of script 
def error(line, error_type):
    line = line + "\n"
    if error_type == 1:
        sys.stderr.write("Fatal error: " + line)
        sys.exit(1)
    if error_type == 2:
        sys.stderr.write("Warning: " + line)
    if error_type == 0:
        print_debug("FIND ERROR: " + line, False, "")

def check_tools(m):
    input_tools=[[[1,4],"m4 --version", "bad m4 version"],
                 [[2,4],"bison --version", "bad bison version"],
                 [[2,5], "flex --version", "bad flex version"]]
    ret = 1 
    for t in range(0,len(input_tools)):
        t1 = ((take_lines(input_tools[t][1], "first"))[:-1].split(" "))
        for i in range(0,len(t1)):
            t11 = t1[i].split(".")
            f = True
            for j in range(0,len(t11)):
                if not t11[j].isdigit():
                    f = False
            if f == True:
                for j in range(0,len(t11)):
                    if j < len(input_tools[t][0]):
                        if int(t11[j])<input_tools[t][0][j]:
                            error(input_tools[t][2], m)
                            ret = 0
                            break
                        if int(t11[j])>input_tools[t][0][j]:
                            break
    return ret
