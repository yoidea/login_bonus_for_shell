# coding: UTF-8
import sys
import os.path
import json
import datetime


def init_log(now):
    output = {
        'last': {
            'year': now.year,
            'month': now.month,
            'day': now.day,
            'hour': now.hour,
            'minute': now.minute,
            'second': now.second
        },
        'continuous': 1,
        'total': 1,
        'today': 0,
        'event': True
    }
    json_output = json.dumps(output, indent=4)
    f = open('logininfo.json', 'w')
    f.write(json_output)
    f.close()


def read_log():
    f = open('logininfo.json', 'r')
    json_log = f.read()
    f.close()
    log = json.loads(json_log)
    return log


def write_log(log, now):
    output = {
        'last': {
            'year': now.year,
            'month': now.month,
            'day': now.day,
            'hour': now.hour,
            'minute': now.minute,
            'second': now.second
        },
        'continuous': log['continuous'],
        'total': log['total'],
        'today': log['today'],
        'event': log['event']
    }
    json_output = json.dumps(output, indent=4)
    f = open('logininfo.json', 'w')
    f.write(json_output)
    f.close()


def show_message(log):
    f = open('message.json', 'r')
    json_message = f.read()
    f.close()
    message = json.loads(json_message)
    print(message['head'])
    print(message['total']['info']),
    print(log['total']),
    print(message['total']['unit'])
    print(message['continuous']['info']),
    print(log['continuous']),
    print(message['continuous']['unit'])
    print(message['today']['info']),
    print(log['today']),
    print(message['today']['unit'])
    print(message['foot'])


def check_event(log):
    f = open('eventlist.json', 'r')
    json_event = f.read()
    f.close()
    event = json.loads(json_event)
    events = event['events']
    for i in range(len(events)):
        if log['event'] or events[i]['condition'] == 'today':
            if log[events[i]['condition']] == events[i]['value']:
                print(events[i]['message'])


if __name__ == '__main__':
    now = datetime.datetime.today()
    if os.path.exists('message.json') == False:
        print('"message.json"が見つかりません')
        sys.exit(1)
    if os.path.exists('eventlist.json') == False:
        print('"eventlist.json"が見つかりません')
        sys.exit(2)
    if os.path.exists('logininfo.json') == False:
        init_log(now)
    log = read_log()
    login = log['last']
    if login['year'] == now.year and login['month'] == now.month and login['day'] == now.day:
        log['today'] += 1
        log['event'] = False
    elif login['day'] == now.day - 1:
        log['continuous'] += 1
        log['total'] += 1
        log['today'] = 1
        log['event'] = True
    else:
        log['continuous'] = 1
        log['total'] += 1
        log['today'] = 1
        log['event'] = True
    write_log(log, now)
    show_message(log)
    check_event(log)
    sys.exit(0)