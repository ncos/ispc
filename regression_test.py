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
from regression import *
from copy import deepcopy
import random
import pickle


ARCHS   = ["x86", "x86-64"]
TARGETS = ["sse2-i32x4", "generic-32", "generic-64", "knc"]

OPTS    = ["-O0", "-O2"]
FNAMES  = ["test0", "test1", "test2", "test3", "test4"]


def add_salt(esg, num_entries):
    for i in xrange(num_entries):
        arch   = ARCHS  [random.randint(0, len(ARCHS  ) - 1)]
        opt    = OPTS   [random.randint(0, len(OPTS   ) - 1)]
        target = TARGETS[random.randint(0, len(TARGETS) - 1)]

        fname  = FNAMES [random.randint(0, len(FNAMES ) - 1)]
        
        runfailed  = 0
        compfailed = 0
        skipped    = 0
        
        test_result = random.randint(0, 2)
        if (test_result == 0):
            runfailed = 1
        if (test_result == 1):
            compfailed = 1
        if (test_result == 2):
            skipped = 1
            
        test = Test(fname, runfailed, compfailed, skipped)
        esg.add_test_result(test, arch, opt, target)


def gen_test_pair(filename):
    with open(filename, 'w') as fp:
        ex_state_1 = ExecutionStatGatherer()
        add_salt(ex_state_1, 10)
        ex_state_2 = deepcopy(ex_state_1)
        ex_state_intersect = deepcopy(ex_state_1)
        add_salt(ex_state_1, 10)
        add_salt(ex_state_2, 15)
        pickle.dump([ex_state_1, ex_state_2, ex_state_intersect], fp)


def read_test_pair(filename):
    with open(filename, 'r') as fp:
        [ex_state_1, ex_state_2, ex_state_intersect] = pickle.load(fp)
    
    return (ex_state_1, ex_state_2, ex_state_intersect)
        
        
if __name__ == '__main__':
    #gen_test_pair("tables.dat")
    ex_state_1, ex_state_2, ex_state_intersect = read_test_pair("tables.dat")
    print ex_state_1
    print "========================="
    print ex_state_2
    print "========================="
    print ex_state_intersect






