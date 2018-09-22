# -*- coding: utf-8 -*-
import math,string,itertools,fractions,heapq,collections,re,array,bisect

class GroupTheNumbers:
    def calculate(self, A):
        N = len(A)
        cnt_0 = 0
        cnt_1 = 0
        cnt_m1 = 0
        cnt_minus = 0
        m = -(10**10)
        for i in xrange(N):
            if A[i] == 0:
                cnt_0 += 1
            elif A[i] == 1:
                cnt_1 += 1
            elif A[i] < 0:
                cnt_minus += 1
                m = max(m, A[i])
                if A[i] == -1:
                    cnt_m1 += 1

        if cnt_minus % 2 == 0:
            ans = 1
            for i in xrange(N):
                if A[i] != 0:
                    ans *= A[i]
            ans += cnt_1
            ans += cnt_m1 / 2
        else:
            ans = 1
            for i in xrange(N):
                if A[i] != 0:
                    ans *= A[i]
            ans /= m
            ans += cnt_1
            if cnt_0 == 0:
                ans += m
            if cnt_m1 > 0:
                ans += (cnt_m1 - 1) / 2

        ans = str(ans)
        return ans if len(ans) <= 203 else ans[:100] + "..." + ans[-100:]

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

def do_test(a, __expected):
    startTime = time.time()
    instance = GroupTheNumbers()
    exception = None
    try:
        __result = instance.calculate(a);
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
    sys.stdout.write("GroupTheNumbers (600 Points)\n\n")

    passed = cases = 0
    case_set = set()
    for arg in sys.argv[1:]:
        case_set.add(int(arg))

    with open("GroupTheNumbers.sample", "r") as f:
        while True:
            label = f.readline()
            if not label.startswith("--"): break

            a = []
            for i in range(0, int(f.readline())):
                a.append(int(f.readline().rstrip()))
            a = tuple(a)
            f.readline()
            __answer = f.readline().rstrip()

            cases += 1
            if len(case_set) > 0 and (cases - 1) in case_set: continue
            sys.stdout.write("  Testcase #%d ... " % (cases - 1))
            passed += do_test(a, __answer)

    sys.stdout.write("\nPassed : %d / %d cases\n" % (passed, cases))

    T = time.time() - 1537391919
    PT, TT = (T / 60.0, 75.0)
    points = 600 * (0.3 + (0.7 * TT * TT) / (10.0 * PT * PT + TT * TT))
    sys.stdout.write("Time   : %d minutes %d secs\n" % (int(T/60), T%60))
    sys.stdout.write("Score  : %.2f points\n" % points)

if __name__ == '__main__':
    run_tests()

# }}}
# CUT end
