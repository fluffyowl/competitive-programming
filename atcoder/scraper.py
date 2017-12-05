import os
import time
import urllib
import json
import pyquery


SLEEP_SEC = 1
EXT = [('Py', '.py'),
       ('C++', '.cc'),
       ('D ', '.d'),
       ('Bash', '.sh'),
       ('Text', '.txt'),
       ('Awk', '.awk'),
       ('C ', '.c')]
DEFAULT_USER_ID = 'nebukuro09'
API = 'http://beta.kenkoooo.com/atcoder/atcoder-api/results?user='
CONTEST_BASE_URL = 'https://beta.atcoder.jp/contests/%s/submissions/%s'
WORK_DIR = os.getcwd()


def get_lang_ext(lang_str):
    for suffix, ext in EXT:
        if lang_str.startswith(suffix):
            return ext
    print(lang_str)
    assert(False)


def get_submissions_json(user_id):
    url = API + user_id
    req = urllib.request.Request(url)
    with urllib.request.urlopen(req) as response:
        submissions_json = response.read()
    return submissions_json


def scrape_submission(submission):
    if submission['result'] != 'AC':
        return False
    if os.path.exists(submission['dest']):
        return False

    if not os.path.exists(os.path.join(WORK_DIR, submission['contest_id'])):
        os.mkdir(submission['contest_id'])

    print(submission['problem_id'])

    source = pyquery.PyQuery(CONTEST_BASE_URL %
                             (submission['contest_id'],
                              submission['id']))

    with open(os.path.join(submission['dest']), 'w') as f:
        s = source.find('pre').text().replace('\r\n', '\n')+'\n'
        f.write(s)

    time.sleep(SLEEP_SEC)
    return True


def main(user_id=DEFAULT_USER_ID):
    submissions_json = get_submissions_json(user_id)
    submissions = json.loads(submissions_json)
    cnt = 0
    for sub in submissions:
        sub['filename'] = sub['problem_id'] + get_lang_ext(sub['language'])
        sub['dest'] = os.path.join(WORK_DIR, sub['contest_id'], sub['filename'])
        cnt += scrape_submission(sub)
    print('Scraped ' + str(cnt) + ' submissions')


if __name__ == '__main__':
    main()
