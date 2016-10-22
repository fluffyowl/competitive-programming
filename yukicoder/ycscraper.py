import time
import pandas

USER_ID = '2392'
SLEEP_SEC = 5
SUBMISSIONS_URL = 'http://yukicoder.me/users/'+USER_ID+'/submissions'
EXT = {'Python2':'.py',
       'PyPy2':'.py',
       'C++11':'.cc',
       'D':'.d',
       'Bash':'.sh'}

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
    return dt

def save_raw_source_code(dt):
    pass

if __name__ == '__main__':
    print get_submissions(USER_ID)
