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

# // Authors: Anton Mitrokhin

from optparse import OptionParser
from common import *
import pickle, re



def read_test_table(filename):
    with open(filename, 'r') as fp:
        tt = pickle.load(fp) 
    return tt
        
def write_test_table(filename, tt):
    with open(filename, 'w') as fp:
        pickle.dump(tt, fp)  


def print_with_specific_results(tests, runfailed, compfailed):
    for test in tests:
        for test_case in test.test_cases:
            if test_case.result == TestResult(runfailed, compfailed):
                print test.name.rjust(40) + repr(test_case).rjust(50)


def merge_tts(tt1, tt2):
    tt = TestTable()
    for rev in tt1.table.keys():
        for test in tt1.table[rev]:
            for test_case in test.test_cases:
                tt.add_result(rev, test.name, test_case.arch, 
                              test_case.opt, test_case.target,
                              test_case.result.runfailed, 
                              test_case.result.compfailed)
    for rev in tt2.table.keys():
        for test in tt2.table[rev]:
            for test_case in test.test_cases:
                tt.add_result(rev, test.name, test_case.arch, 
                              test_case.opt, test_case.target,
                              test_case.result.runfailed, 
                              test_case.result.compfailed)
    return tt

def check_rev_in_tt(tt, rev, tt_location):
    if not rev in tt.table.keys():
        print "Unable to locate", rev, "in table", tt_location
        print "Available LLVM revisions:", tt.table.keys()
        exit(0)



if __name__ == '__main__':
    # parsing options
    class MyParser(OptionParser):
        def format_epilog(self, formatter):
            return self.epilog

    examples =  ("Examples:\n" +
    "Load test_table object\n\tregression_read.py -l 'test_table.dump'\n" +
    "Show runfailed, compfailed and succeed tests in rev '213493'\n\t" + 
    "regression_read.py -l 'test_table.dump' -r '213493' --succeed --runfailed --compfailed\n" +
    "Show regression between two revisions\n\t" +
    "regression_read.py -l 'test_table.dump' -R '210929 213493'\n")

    parser = MyParser(usage="Usage: regression_read.py -l [options]", epilog=examples)
    parser.add_option('-l', '--load-tt', dest='load_tt',
        help='load TestTable() from file', default=None)
    parser.add_option('-r', '--revision', dest='revision',
        help='show only specified revision', default=None)
    parser.add_option('--runfailed', dest='runfailed',
        help='show runfailed tests', default=False, action='store_true')
    parser.add_option('--compfailed', dest='compfailed',
        help='show compfailed tests', default=False, action='store_true')
    parser.add_option('--succeed', dest='succeed',
        help='show succeed tests', default=False, action='store_true')
    parser.add_option('-R', '--regression', dest='regression',
        help='show regression between two specified revisions', default="")
    # options for table merging:
    parser.add_option('--save-to', dest='save_tt',
        help='when merging specify location to save the result test table', default="")
    parser.add_option('--merge', dest='merge_tt',
        help='when merging specify location of test table to merge with', default="")
    parser.add_option('--automerge', dest='automerge',
        help='this will merge the input test table with all ones found in alloy_results... dirs', default=False, action='store_true')


    (options, args) = parser.parse_args()
    if (options.load_tt == None):
        print "ERROR: -l (--load-tt) unset"
        parser.print_help()
        exit(0)
   
    if (options.automerge == True or options.merge_tt != "") and options.save_tt == "":
        print "ERROR: --save-to option should be set with --merge and --automerge"
        parser.print_help()
        exit(0)

    _tt = read_test_table(options.load_tt)
    ex_state.load_from_tt(_tt)
    print ex_state

    if options.revision != None:
        check_rev_in_tt(ex_state.tt, options.revision, options.load_tt)
        revisions = [options.revision]
    else:
        revisions = ex_state.tt.table.keys()


    # print test cases
    if (options.succeed):
        print "\n\n Succeed:"
        for rev in revisions:
            print "Revision %s" % (rev)
            print_with_specific_results(ex_state.tt.table[rev], 0, 0)

    if (options.runfailed):
        print "\n\n Runfailed:"
        for rev in revisions:
            print "Revision %s" % (rev)
            print_with_specific_results(ex_state.tt.table[rev], 1, 0)

    if (options.compfailed):
        print "\n\n Compfailed:"
        for rev in revisions:
            print "Revision %s" % (rev)
            print_with_specific_results(ex_state.tt.table[rev], 0, 1)
            
     
    # print regression
    if options.regression != "":
        regr_revs = re.split('\ ', options.regression)
        if len(regr_revs) != 2:
            print "Invalid input:", regr_revs
            exit(0)

        check_rev_in_tt(ex_state.tt, regr_revs[0], options.load_tt)
        check_rev_in_tt(ex_state.tt, regr_revs[1], options.load_tt)

        print ex_state.tt.regression(regr_revs[0], regr_revs[1])

    # merge tables if specified
    if (options.merge_tt != ""):
        tt1 = ex_state.tt
        tt2 = read_test_table(options.merge_tt)
        tt = merge_tts(tt1, tt2)
        write_test_table(options.save_tt, tt)

    if (options.automerge == True):
        tt = ex_state.tt
        for elem in os.listdir(os.getcwd()):
            if "alloy_results" in elem:
                try:
                    files = os.listdir(os.getcwd() + os.sep + elem)
                except:
                    continue
                for f in files:
                    if ".dump" in f:
                        try:
                            print os.getcwd() + os.sep + elem + os.sep + f
                            tt2 = read_test_table(os.getcwd() + os.sep + elem + os.sep + f)
                            tt = merge_tts(tt, tt2)
                        except:
                            continue   
        write_test_table(options.save_tt, tt)
