# -*- coding: utf-8 -*-

import os
import time
import urllib2
import pandas
import json
import pyquery

SLEEP_SEC = 1
EXT = [('Py', '.py'),
       ('C++', '.cc'),
       ('D ', '.d'),
       ('Bash', '.sh'),
       ('Text', '.txt'),
       ('Awk', '.awk')]
USER_NAME = 'nebukuro09'
CONTEST_BASE_URL = '.contest.atcoder.jp/submissions/all?status=AC&user_screen_name='


def get_lang_ext(lang_str):
    for suffix, ext in EXT:
        if lang_str.startswith(suffix):
            return ext
    assert(False)


def get_contest_IDs():
    return [i['id'] for i in json.loads(urllib2.urlopen('http://kenkoooo.com/atcoder/json/contests.json').read())]


def get_my_submissions(contest_id, user_id):
    url = 'http://' + contest_id + CONTEST_BASE_URL + user_id
    try:
        df = pandas.io.html.read_html(url, encoding='utf-8')[0]
    except ValueError:
        return pandas.DataFrame()
    time.sleep(SLEEP_SEC)
    d = pyquery.PyQuery(url)
    time.sleep(SLEEP_SEC)
    df['problem_id'] = pandas.Series(pyquery.PyQuery(a).attr('href').replace('/tasks/', '') for a in d.find('tbody > tr > td > a')[::4])
    df['submission_id'] = pandas.Series(pyquery.PyQuery(a).attr('href').replace('/submissions/', '') for a in d.find('tbody > tr > td > a')[3::4])
    return df


if __name__ == '__main__':
    contest_ids = get_contest_IDs()
    workdir = os.getcwd()
    for contest in contest_ids:
        os.chdir(workdir)
        print contest
        if not os.path.exists(contest):
            os.mkdir(contest)
        os.chdir(contest)
        df = get_my_submissions(contest, USER_NAME)
        if df.empty:
            continue
        for i, r in df.iterrows():
            filename = r['problem_id'] + get_lang_ext(r[u'Language言語'])
            print '    ' + filename,
            if os.path.exists(filename):
                print 'skipped'
                continue
            print
            source = pyquery.PyQuery('http://' + contest + '.contest.atcoder.jp/submissions/' + r['submission_id'])
            time.sleep(SLEEP_SEC)
            with open(filename, 'w') as f:
                s = source.find('pre').text().replace('\r\n', '\n')+'\n'
                f.write(s.encode('utf8'))
