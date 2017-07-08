# -*- coding: utf-8 -*-
import math,string,itertools,fractions,heapq,collections,re,array,bisect

class ConstructLCS:
    def construct(self, ab, bc, ca):
        if ab == max(ab, bc, ca):
            a = '1' * ab
            b = '1' * ab
            c = '1' * min(bc, ca)
            if bc != min(ab, bc, ca):
                b += '0' * (bc - ca)
                c += '0' * (bc - ca)
            else:
                a += '0' * (ca - bc)
                c += '0' * (ca - bc)
        elif bc == max(ab, bc, ca):
            a = '1' * min(ab, ca)
            b = '1' * bc
            c = '1' * bc
            if ab != min(ab, bc, ca):
                a += '0' * (ab - ca)
                b += '0' * (ab - ca)
            else:
                a += '0' * (ca - ab)
                c += '0' * (ca - ab)
        else:
            a = '1' * ca
            b = '1' * min(ab, bc)
            c = '1' * ca
            if ab != min(ab, bc, ca):
                a += '0' * (ab - bc)
                b += '0' * (ab - bc)
            else:
                b += '0' * (bc - ab)
                c += '0' * (bc - ab)

        return a + ' ' + b + ' ' + c

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

def do_test(ab, bc, ca, __expected):
    startTime = time.time()
    instance = ConstructLCS()
    exception = None
    try:
        __result = instance.construct(ab, bc, ca);
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
    sys.stdout.write("ConstructLCS (250 Points)\n\n")

    passed = cases = 0
    case_set = set()
    for arg in sys.argv[1:]:
        case_set.add(int(arg))

    with open("ConstructLCS.sample", "r") as f:
        while True:
            label = f.readline()
            if not label.startswith("--"): break

            ab = int(f.readline().rstrip())
            bc = int(f.readline().rstrip())
            ca = int(f.readline().rstrip())
            f.readline()
            __answer = f.readline().rstrip()

            cases += 1
            if len(case_set) > 0 and (cases - 1) in case_set: continue
            sys.stdout.write("  Testcase #%d ... " % (cases - 1))
            passed += do_test(ab, bc, ca, __answer)

    sys.stdout.write("\nPassed : %d / %d cases\n" % (passed, cases))

    T = time.time() - 1498525887
    PT, TT = (T / 60.0, 75.0)
    points = 250 * (0.3 + (0.7 * TT * TT) / (10.0 * PT * PT + TT * TT))
    sys.stdout.write("Time   : %d minutes %d secs\n" % (int(T/60), T%60))
    sys.stdout.write("Score  : %.2f points\n" % points)

if __name__ == '__main__':
    run_tests()

# }}}
# CUT end
