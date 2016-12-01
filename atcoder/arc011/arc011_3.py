import Queue

alphabets = 'abcdefghijklmnopqrstuvwxyz'
_end = '_end_'
def make_trie(*words):
    root = dict()
    for word in words:
        current_dict = root
        for letter in word:
            current_dict = current_dict.setdefault(letter, {})
        current_dict[_end] = _end
    return root

def in_trie(trie, word):
    current_dict = trie
    for letter in word:
        if letter in current_dict:
            current_dict = current_dict[letter]
        else:
            return False
    else:
        if _end in current_dict:
            return True
        else:
            return False

def get_adj_words(trie, word):
    result = []
    for i, c in enumerate(word):
        word_L = list(word)
        for alp in alphabets:
            if alp == c:
                continue
            word_L[i] = alp
            if in_trie(trie, ''.join(word_L)):
                result.append(''.join(word_L))
    return result

def bfs(start, goal):
    q = Queue.Queue()
    q.put((start, None, 0))
    parents = {}
    while not q.empty():
        word, parent, depth = q.get()
        if word in parents:
            continue
        parents[word] = parent
        if word == goal:
            return parents
        for next_word in get_adj_words(trie, word):
            q.put((next_word, word, depth+1))
    return parents
    
start, goal = raw_input().split()
if start == goal:
    print 0
    print start
    print goal
    exit()
words = [raw_input() for i in xrange(input())] + [start, goal]
trie = make_trie(*words)
d =  bfs(start, goal)
ans = [goal]
while ans[-1] != start:
    try:
        ans.append(d[ans[-1]])
    except:
        print -1
        exit()
print len(ans)-2
for i in xrange(len(ans)-1, -1, -1):
    print ans[i]
