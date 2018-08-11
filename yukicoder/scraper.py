# -*- coding: utf-8 -*-

import os
import sys
import time
import codecs
import urllib2
import pandas

USER_ID = '2392'
SLEEP_SEC = 5
SUBMISSIONS_URL = 'http://yukicoder.me/users/'+USER_ID+'/submissions'
file_prefix = 'yuki_'
EXT = {'Python2': '.py',
       'PyPy2': '.py',
       'C++11': '.cpp',
       'C++14': '.cpp',
       u'C++17(1z）': '.cpp',
       'C++17(clang Beta)': 'cpp',
       'D': '.d',
       'Bash': '.sh',
       'Text': '.txt',
       'Kotlin': '.kt',
       'Perl': '.pl',
       'JavaScript': '.js',
       'Vim script': '.vim',
       'F#': '.fs',
       'Haskell': '.hs',
       'Lua': '.lua',
       'Ruby': '.rb',
       'Scheme': '.scm',
       'Elixir': '.ex'}
TESTJSON = 'test.json'


def get_submissions(user_id, status='AC'):
    base_url = SUBMISSIONS_URL + '?status=' + status + '&page='
    dt = pandas.io.html.read_html(base_url+'1', encoding='utf-8')[0]
    for page in xrange(2, 100):
        time.sleep(SLEEP_SEC)
        dt2 = pandas.io.html.read_html(base_url+str(page), encoding='utf-8')[0]
        if dt2.empty:
            break
        dt = pandas.concat([dt, dt2])
        print page
    return dt.sort_index(by='#', ascending=True)

def save_raw_source_code(dt):
    files = [f for f in os.listdir('.') if os.path.isfile(f)]
    for i, row in dt.iterrows():
        number = int(row[u'問題'].split()[0][3:])
        filename = file_prefix + '%04d'%number + EXT[row[u'言語']]
        print filename
        if filename in files:
            continue
        url = 'http://yukicoder.me/submissions/' + str(row['#']) + '/source'
        download = urllib2.urlopen(url)
        with codecs.open(filename, 'w', 'utf-8') as f:
            f.write(unicode(download.read(), 'utf-8'))
            f.write('\n')
        time.sleep(SLEEP_SEC)

if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1].lower() == 'test':
        save_raw_source_code(pandas.read_json(TESTJSON))
    else:
        save_raw_source_code(get_submissions(USER_ID))
