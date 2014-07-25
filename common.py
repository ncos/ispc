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

# // Author: Filippov Ilia, Anton Mitrokhin, Vsevolod Livinskiy
import os, sys
import subprocess
import errno
import shutil, re


# retrieve the host name
def get_host_name():
    import socket
    return socket.gethostname()


# return tre 'real' (that is the last appeared in svn log) revision number 
# 'path' is the path to the local svn repo
def svn_version(path):
    p = subprocess.Popen('svn info ' + path, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (svninfo, err) = p.communicate()
    if len(err) != 0: # In case of a failure 
        raise IOError(err)

    info_llvm = [re.split(': ', line) for line in re.split('\n', svninfo)]
    
    for entry in info_llvm:
        if entry[0] == 'Last Changed Rev':
            return int(entry[1])


# get the 'real' (that is the last appeared in svn log) revision number of llvm trunk revision
# the 'revision' is an svn revision number
def get_real_revision(revision):
    svn_path = 'http://llvm.org/svn/llvm-project/llvm/trunk'
    p = subprocess.Popen('svn info -r' + str(revision) + ' ' + svn_path, shell=True, 
                                            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (svninfo, err) = p.communicate()
    if len(err) != 0: # In case of a failure 
        raise IOError(err)

    info_llvm = [re.split(': ', line) for line in re.split('\n', svninfo)]
    
    for entry in info_llvm:
        if entry[0] == 'Last Changed Rev':
            return int(entry[1])


# load/save almost every object to a file (good for bug reproducing)
def dump(fname, obj):
    import pickle
    with open(fname, 'w') as fp:
        pickle.dump(obj, fp)  

def undump(fname):
    import pickle
    with open(fname, 'r') as fp:
        obj = pickle.load(fp) 
    return obj

# retrieve the host name
def get_host_name():
    import socket
    return socket.gethostname()

def write_to_file(filename, line):
    f = open(filename, 'a')
    f.writelines(line)
    f.close()

# remove file if it exists
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





# regression test functionality
class TestResult(object):
    """
    this class stores basicly two integers which stand for the result
    of the test: (runfail{0/1}, compfail{0/1}). other values are 
    deemed invalid. the __cmp__ function of this class is used to 
    define what test regression actually is.
    """
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
    """
    the TestCase() is a combination of parameters the tast was run with:
    the architecture (x86, x86-64 ...), compiler optimization (-O0, -O2 ...)
    and target (sse, avx ...). we also store the result of the test here.
    """
    def __init__(self, arch, opt, target):
        self.arch, self.opt, self.target = (arch, opt, target)
        self.result = TestResult(-1, -1)

    def __repr__(self):
        string = "%s %s %s: " % (self.arch, self.opt, self.target)
        string = string + repr(self.result)
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
    """
    Test() stores all TestCase() objects for a given test file name
    i.e. all archs/opts/targets/ and corresponding testing results.
    """
    def __init__(self, name):
        self.name = name
        self.test_cases = []

    def add_result(self, test_case):
        if test_case in self.test_cases:
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
    """
    service class which provides some statistics on a given regression.
    the regression test names and cases are given in a form of Test() objects
    with empty (-1, -1) results 
    """
    def __init__(self, revision_old, revision_new, tests):
        self.revision_old, self.revision_new = (revision_old, revision_new)
        self.tests = tests
        self.archfails = {}
        self.optfails = {}
        self.targetfails = {}
        self.testfails = {}
        self.archs = []
        self.opts = []
        self.targets = []

        for test in tests:
            for test_case in test.test_cases:
                self.inc_dictionary(self.testfails, test.name)
                self.inc_dictionary(self.archfails, test_case.arch)
                self.inc_dictionary(self.optfails, test_case.opt)
                self.inc_dictionary(self.targetfails, test_case.target)
        
        self.archs = self.archfails.keys()
        self.opts = self.optfails.keys()
        self.targets = self.targetfails.keys()

    def inc_dictionary(self, dictionary, key):
        if key not in dictionary:
            dictionary[key] = 0
        dictionary[key] += 1

    def __repr__(self):
        string = "Regression of LLVM revision %s in comparison to %s\n" % (self.revision_new, self.revision_old)
        string += repr(self.tests) + '\n'
        string += str(self.testfails) + '\n'
        string += str(self.archfails) + '\n'
        string += str(self.optfails) + '\n'
        string += str(self.targetfails) + '\n'

        return string


class TestTable(object):
    """
    the table which stores a tuple of Test() objects (one per revision) and has some 
    convenience methods for dealing with them
    """
    def __init__(self):
        """ This dictionary contains {rev: [test1, test2, ...], ...}, where 'rev' is a string (revision name) and 'test#'
        is a Test() object instance """
        self.table = {}
        self.broken = []

    def set_broken(self, rev_name):
        if str(rev_name) not in self.broken:
            self.broken.append(str(rev_name))

    def add_result(self, revision_name, test_name, arch, opt, target, runfailed, compfailed):
        revision_name = str(revision_name)
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
        """ Return test cases common for test1 and test2. If test names are different than there is nothing in common """
        if test1.name != test2.name:
            return []
        return list(set(test1.test_cases) & set(test2.test_cases))

    def test_regression(self, test1, test2):
        """ Return the tuple of empty (i.e. with undefined results) TestCase() objects 
            corresponding to regression in test2 comparing to test1 """
        if test1.name != test2.name:
            return []

        regressed = []
        for tc1 in test1.test_cases:
            for tc2 in test2.test_cases:
                """ If test cases are equal (same arch, opt and target) but tc2 has more runfails or compfails """
                if tc1 == tc2 and tc1.result < tc2.result:
                    _tc = TestCase(tc1.arch, tc1.opt, tc1.target)
                    _tc.result = tc2.result
                    regressed.append(_tc)
        return regressed
 
    def regression(self, revision_old, revision_new):
        """ Return a tuple of Test() objects containing TestCase() object which show regression along given revisions """
        revision_old, revision_new = (str(revision_old), str(revision_new))
        if revision_new not in self.table:
            raise RuntimeError("This revision in not in the database: " + str(revision_new) + " (" + str(self.table.keys()) + ")")
            return

        if revision_old not in self.table:
            raise RuntimeError("This revision in not in the database: " + str(revision_old) + " (" + str(self.table.keys()) + ")")
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


class ExecutionStateGatherer(object):
    def __init__(self):
        self.hostname = self.get_host_name()
        self.revision = ""
        self.tt = TestTable()

    def switch_revision(self, revision):
        print "Switching revision to " + str(revision)
        self.revision = str(revision)

    def add_to_tt(self, test_name, arch, opt, target, runfailed, compfailed):
        self.tt.add_result(self.revision, test_name, arch, opt, target, runfailed, compfailed)

    def load_from_tt(self, tt):
        self.tt = tt
        self.revision = ""
        if len(self.tt.table.keys()) != 0:
            self.revision = self.tt.table.keys()[0]
        print "loaded from 'TestTable()' with revisions", self.tt.table.keys()

    def get_rev_info(self, rev):
        if rev not in self.tt.table:
            return ([], [], [])
        ri = RegressionInfo(-1, -1, self.tt.table[rev])
        return (ri.archs, ri.opts, ri.targets)

    def dump(self, fname, obj):
        import pickle
        with open(fname, 'w') as fp:
            pickle.dump(obj, fp)  

    def undump(self, fname):
        import pickle
        with open(fname, 'r') as fp:
            obj = pickle.load(fp) 
        return obj

    def get_host_name(self):
        import socket
        return socket.gethostname()

    def __repr__(self):
        string = "Hostname: %s\n" % (self.hostname)
        string += "Current LLVM Revision = %s\n" % (self.revision)
        string += "Revisions in table: " + str(self.tt.table.keys())
        return string


# this class instance is intended to gather and store all information
# regarding the testing process.
ex_state = ExecutionStateGatherer()   
