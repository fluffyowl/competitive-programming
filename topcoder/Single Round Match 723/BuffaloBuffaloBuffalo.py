# -*- coding: utf-8 -*-
import math,string,itertools,fractions,heapq,collections,re,array,bisect

sbuffalo = set('buffalo?')
MOD = 10**9 + 7

class BuffaloBuffaloBuffalo:
    def count(self, pattern):
        self.pattern = pattern
        self.N = len(pattern)

        N = len(pattern)

        if N % 7 != 0:
            return 0

        sp = set(pattern)
        for c in string.ascii_lowercase:
            if c not in sbuffalo and c in sp:
                return 0

        self.mem = [{} for _ in xrange(N)]
        return self.dfs(0, (N/7, 0, 0, 0, 0, 0, 0, 0))

    def dfs(self, n, comb):
        if n >= self.N:
            if comb[7] == self.N / 7:
                return 1
            else:
                return 0

        if comb in self.mem[n]:
            return self.mem[n][comb]

        ncomb = list(comb)

        if self.pattern[n] == 'b':
            if comb[0] == 0:
                self.mem[n][comb] = 0
            else:
                ncomb[0] -= 1
                ncomb[1] += 1
                self.mem[n][comb] = self.dfs(n+1, tuple(ncomb))
        elif self.pattern[n] == 'u':
            if comb[1] == 0:
                self.mem[n][comb] = 0
            else:
                ncomb[1] -= 1
                ncomb[2] += 1
                self.mem[n][comb] = self.dfs(n+1, tuple(ncomb))
        elif self.pattern[n] == 'f':
            if comb[2] == 0 and comb[3] == 0:
                self.mem[n][comb] = 0
            else:
                if comb[3] > 0:
                    ncomb[3] -= 1
                    ncomb[4] += 1
                else:
                    ncomb[2] -= 1
                    ncomb[3] += 1
                self.mem[n][comb] = self.dfs(n+1, tuple(ncomb))
        elif self.pattern[n] == 'a':
            if comb[4] == 0:
                self.mem[n][comb] = 0
            else:
                ncomb[4] -= 1
                ncomb[5] += 1
                self.mem[n][comb] = self.dfs(n+1, tuple(ncomb))
        elif self.pattern[n] == 'l':
            if comb[5] == 0:
                self.mem[n][comb] = 0
            else:
                ncomb[5] -= 1
                ncomb[6] += 1
                self.mem[n][comb] = self.dfs(n+1, tuple(ncomb))
        elif self.pattern[n] == 'o':
            if comb[6] == 0:
                self.mem[n][comb] = 0
            else:
                ncomb[6] -= 1
                ncomb[7] += 1
                self.mem[n][comb] = self.dfs(n+1, tuple(ncomb))
        else:
            self.mem[n][comb] = 0
            for i in xrange(7):
                ncomb = list(comb)
                if i == 2:
                    if comb[3] > 0:
                        ncomb[3] -= 1
                        ncomb[4] += 1
                        self.mem[n][comb] += self.dfs(n+1, tuple(ncomb))
                    elif comb[2] > 0:
                        ncomb[2] -= 1
                        ncomb[3] += 1
                        self.mem[n][comb] += self.dfs(n+1, tuple(ncomb))
                elif i == 3:
                    continue
                else:
                    if ncomb[i] > 0:
                        ncomb[i] -= 1
                        ncomb[i+1] += 1
                        self.mem[n][comb] += self.dfs(n+1, tuple(ncomb))

        return self.mem[n][comb] % MOD



# CUT begin
# TEST CODE FOR PYTHON {{{
import sys, time, math

def tc_equal(expected, received):
    try:
        _t = type(expected)
        received = _t(received)
        if _t == list or _t == tuple:
            if len(expected) != len(received): return False
            return all(tc_equal(e, r) for (e, r) in zip(expected, received))
        elif _t == float:
            eps = 1e-9
            d = abs(received - expected)
            return not math.isnan(received) and not math.isnan(expected) and d <= eps * max(1.0, abs(expected))
        else:
            return expected == received
    except:
        return False

def pretty_str(x):
    if type(x) == str:
        return '"%s"' % x
    elif type(x) == tuple:
        return '(%s)' % (','.join( (pretty_str(y) for y in x) ) )
    else:
        return str(x)

def do_test(pattern, __expected):
    startTime = time.time()
    instance = BuffaloBuffaloBuffalo()
    exception = None
    try:
        __result = instance.count(pattern);
    except:
        import traceback
        exception = traceback.format_exc()
    elapsed = time.time() - startTime   # in sec

    if exception is not None:
        sys.stdout.write("RUNTIME ERROR: \n")
        sys.stdout.write(exception + "\n")
        return 0

    if tc_equal(__expected, __result):
        sys.stdout.write("PASSED! " + ("(%.3f seconds)" % elapsed) + "\n")
        return 1
    else:
        sys.stdout.write("FAILED! " + ("(%.3f seconds)" % elapsed) + "\n")
        sys.stdout.write("           Expected: " + pretty_str(__expected) + "\n")
        sys.stdout.write("           Received: " + pretty_str(__result) + "\n")
        return 0

def run_tests():
    sys.stdout.write("BuffaloBuffaloBuffalo (500 Points)\n\n")

    passed = cases = 0
    case_set = set()
    for arg in sys.argv[1:]:
        case_set.add(int(arg))

    with open("BuffaloBuffaloBuffalo.sample", "r") as f:
        while True:
            label = f.readline()
            if not label.startswith("--"): break

            pattern = f.readline().rstrip()
            f.readline()
            __answer = int(f.readline().rstrip())

            cases += 1
            if len(case_set) > 0 and (cases - 1) in case_set: continue
            sys.stdout.write("  Testcase #%d ... " % (cases - 1))
            passed += do_test(pattern, __answer)

    sys.stdout.write("\nPassed : %d / %d cases\n" % (passed, cases))

    T = time.time() - 1511026284
    PT, TT = (T / 60.0, 75.0)
    points = 500 * (0.3 + (0.7 * TT * TT) / (10.0 * PT * PT + TT * TT))
    sys.stdout.write("Time   : %d minutes %d secs\n" % (int(T/60), T%60))
    sys.stdout.write("Score  : %.2f points\n" % points)

if __name__ == '__main__':
    run_tests()

# }}}
# CUT end
