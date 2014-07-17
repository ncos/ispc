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
from regression import *


class RevisionInfo(object):
    def __init__(self, hostname, revision):
        self.hostname, self.revision = hostname, revision
        self.archs = []
        self.opts = []
        self.targets = []
        self.succeed = 0
        self.runfailed = 0
        self.compfailed = 0
        self.skipped = 0
        self.testall = 0
        self.regressions = {}
    
    def register_test(self, arch, opt, target, succeed, runfailed, compfailed, skipped):
        if arch not in self.archs:
            self.archs.append(arch)
        if opt not in self.opts:
            self.opts.append(opt)
        if target not in self.targets:
            self.targets.append(target)
        self.runfailed += runfailed
        self.compfailed += compfailed
        self.skipped += skipped
        self.succeed += succeed

    def add_regression(self, revision, regression_info):
        ''' input is intended to be from 'TestTable.regression(..)', 'regression_info' is a tuple of RegressionInfo() object
        (regression.py) and 'revision' is tested (not current) LLVM revision name '''
        if revision == self.revision:
            raise RuntimeError("No regression can be found along the same LLVM revision!")
      
        if revision in self.regressions:
            raise RuntimeError("This revision regression info is already in self.regressions!")
      
        self.regressions[revision] = regression_info

    def __repr__(self):
        string = "%s: LLVM(%s)\n" % (self.hostname, self.revision)
        string += "archs  : %s\n" % (str(self.archs))
        string += "opts   : %s\n" % (str(self.opts))
        string += "targets: %s\n" % (str(self.targets))
        string += "runfails: %d/%d\n" % (self.runfailed, self.testall)
        string += "compfails: %d/%d\n" % (self.compfailed, self.testall)
        string += "skipped: %d/%d\n" % (self.skipped, self.testall)
        string += "succeed: %d/%d\n" % (self.succeed, self.testall)
        return string

class ExecutionStateGatherer(object):
    def __init__(self):
        self.hostname = self.get_host_name()
        self.revision = ""
        self.rinf = []
        self.tt = TestTable()

    def switch_revision(self, revision):
        print "Switching revision to " + revision
        self.revision = revision
        self.rinf.append(RevisionInfo(self.hostname, self.revision))

    def current_rinf(self):
        if len(self.rinf) == 0:
            raise RuntimeError("self.rinf is empty. Apparently you've never invoked switch_revision")
        return self.rinf[len(self.rinf) - 1]

    def add_to_tt(self, test_name, arch, opt, target, runfailed, compfailed):
        if len(self.rinf) == 0:
            raise RuntimeError("self.rinf is empty. Apparently you've never invoked switch_revision")
        self.tt.add_result(self.revision, test_name, arch, opt, target, runfailed, compfailed)

    def add_to_rinf(self, arch, opt, target, succeed, runfailed, compfailed, skipped):
        self.current_rinf().register_test(arch, opt, target, succeed, runfailed, compfailed, skipped)

    def add_to_rinf_testall(self, tried_to_test):
        self.current_rinf().testall += tried_to_test

    def load_from_tt(self, tt):
        # TODO: fill in self.rinf field!
        self.tt = tt
        REVISIONS = tt.table.keys()
        self.revision = ""
        if len(REVISIONS) != 0:
            self.revision = REVISIONS[0]
        print "ESG: loaded from 'TestTable()' with revisions", REVISIONS

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
        string += "Current LLVM Revision = %s\n\n" % (self.revision)
        for rev_info in self.rinf:
            string += repr(rev_info) + '\n'
        return string


# this class instance is intended to gather and store all information
# regarding the testing process. Defined in 'regression.py'
ex_state = ExecutionStateGatherer()

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
