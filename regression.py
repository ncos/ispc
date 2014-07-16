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

class TestResult(object):
    def __init__(self, runfailed, compfailed):
        self.runfailed, self.compfailed = (runfailed, compfailed)

    def __cmp__(self, other):
        if isinstance(other, TestResult):
            if self.runfailed == other.runfailed   and \
               self.compfailed == other.compfailed:
                return 0
            elif self.compfailed > other.compfailed:
                return 1
            elif self.runfailed > other.runfailed and \
                 self.compfailed == other.compfailed:
                return 1
            else:
                return -1

        raise RuntimeError("Wrong type for comparioson")
        return NotImplemented

    def __repr__(self):
        if (self.runfailed < 0 or self.compfailed < 0):
            return "(Undefined)"
        return "(r%d c%d)" % (self.runfailed, self.compfailed)


class TestCase(object):
    def __init__(self, arch, opt, target):
        self.arch, self.opt, self.target = (arch, opt, target)
        self.result = TestResult(-1, -1)

    def __repr__(self):
        string = "%s %s %s: " % (self.arch, self.opt, self.target)
        string = string + repr(self.result) + '\n'
        return string

    def __hash__(self):
        return hash(self.arch + self.opt + self.target)

    def __ne__(self, other):
        if isinstance(other, TestCase):
            if hash(self.arch + self.opt + self.target) != hash(other):
                return True
            return False
        raise RuntimeError("Wrong type for comparioson")
        return NotImplemented

    def __eq__(self, other):
        if isinstance(other, TestCase):
            return not self.__ne__(other)   
        raise RuntimeError("Wrong type for comparioson")
        return NotImplemented


class Test(object):
    def __init__(self, name):
        self.name = name
        self.test_cases = []

    def add_result(self, test_case):
        if test_case in self.test_cases:
            raise RuntimeError("This test case is already in the list: " + repr(test_case))
            return
        self.test_cases.append(test_case)

    def __repr__(self):
        string = self.name + '\n'
        string = string.rjust(20)
        for test_case in self.test_cases:
            string += repr(test_case).rjust(60) + '\n'
        return string
    
    def __hash__(self):
        return hash(self.name)

    def __ne__(self, other):
        if isinstance(other, Test):
            if hash(self) != hash(other):
                return True
            return False
        return NotImplemented

    def __eq__(self, other):
        if isinstance(other, Test):
            return not self.__ne__(other)   
        return NotImplemented


class RegressionInfo(object):
    def __init__(self, revision_old, revision_new, tests):
        self.revision_old, self.revision_new = (revision_old, revision_new)
        self.tests = tests
        self.archfailes = {}
        self.optfails = {}
        self.targetfails = {}
        self.testfails = {}

        for test in tests:
            for test_case in test.test_cases:
                self.inc_dictionary(self.testfails, test.name)
                self.inc_dictionary(self.archfailes, test_case.arch)
                self.inc_dictionary(self.optfails, test_case.opt)
                self.inc_dictionary(self.targetfails, test_case.target)

    def inc_dictionary(self, dictionary, key):
        if key not in dictionary:
            dictionary[key] = 0
        dictionary[key] += 1

    def __repr__(self):
        string = "Regression of LLVM revision %s in comparison to %s\n" % (self.revision_new, self.revision_old)
        string += repr(self.tests) + '\n'
        string += str(self.testfails) + '\n'
        string += str(self.archfailes) + '\n'
        string += str(self.optfails) + '\n'
        string += str(self.targetfails) + '\n'

        return string

        
class TestTable(object):
    def __init__(self):
        ''' This dictionary contains {rev: [test1, test2, ...], ...}, where 'rev' is a string (revision name) and 'test#'
            is a Test() object instance '''
        self.table = {}

    def add_result(self, revision_name, test_name, arch, opt, target, runfailed, compfailed):
        if revision_name not in self.table:
            self.table[revision_name] = []
        
        test_case = TestCase(arch, opt, target)
        test_case.result = TestResult(runfailed, compfailed)

        for test in self.table[revision_name]:
            if test.name == test_name:
                test.add_result(test_case)
                return
        
        test = Test(test_name)
        test.add_result(test_case)
        self.table[revision_name].append(test)


    def test_intersection(self, test1, test2):
        ''' Return test cases common for test1 and test2. If test names are different than there is nothing in common '''
        if test1.name != test2.name:
            return []
        return list(set(test1.test_cases) & set(test2.test_cases))

    def test_regression(self, test1, test2):
        ''' Return the tuple of empty (i.e. with undefined results) TestCase() objects 
            corresponding to regression in test2 comparing to test1 '''
        if test1.name != test2.name:
            return []

        regressed = []
        for tc1 in test1.test_cases:
            for tc2 in test2.test_cases:
                ''' If test cases are equal (same arch, opt and target) but tc2 has more runfails or compfails '''
                if tc1 == tc2 and tc1.result < tc2.result:
                    regressed.append(TestCase(tc1.arch, tc1.opt, tc1.target))
        return regressed

    def regression(self, revision_old, revision_new):
        ''' Return a tuple of Test() objects containing TestCase() object which show regression along given revisions '''
        if revision_new not in self.table:
            raise RuntimeError("This revision in not in the database: " + revision_new + " (" + str(self.table.keys()) + ")")
            return

        if revision_old not in self.table:
            raise RuntimeError("This revision in not in the database: " + revision_old + " (" + str(self.table.keys()) + ")")
            return

        regressed = []
        for test_old in self.table[revision_old]:
            for test_new in self.table[revision_new]:
                tr = self.test_regression(test_old, test_new)
                if len(tr) == 0:
                    continue
                test = Test(test_new.name)
                for test_case in tr:
                    test.add_result(test_case)
                regressed.append(test)
        return RegressionInfo(revision_old, revision_new, regressed)
    
    def __repr__(self):
        string = ""
        for rev in self.table.keys():
            string += "[" + rev + "]:\n"
            for test in self.table[rev]:
                string += repr(test) + '\n'
        return string

 
