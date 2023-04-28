import datetime as dt
from pyngrok import ngrok
from time import sleep
from Infinitydatabase import Infinitydatabase
import os

def getreal_date():
    date =dt.datetime.now()
    delta =dt.timedelta(hours=5, minutes=30)
    date =(date+delta)
    return date

def send_Notify(db, notify_table, Place, Level, Info):
    day =getreal_date()
    date =day.date()
    time =day.time()        
    result =db.query(f'select Times, NewDate, NewTime, OldDate, OldTime from {notify_table} where place="{Place}" and level="{Level}" and info="{Info}"')
    row =result['row']
    if row:
        times =row[0][0]; lastdate =row[0][1]; lasttime =row[0][2]
        olddate =row[0][3]; oldtime =row[0][4]
        query =f'update {notify_table} set Times={int(times)+1}, Notify=true'
        if olddate =='NULL' and oldtime =='NULL':
            query +=f', OldDate="{lastdate}", OldTime="{lasttime}"'
        query+=f', NewDate="{date.strftime(r"%Y-%m-%d")}", NewTime="{time.strftime("%H:%M %p")}" where place="{Place}" and level="{Level}" and info="{Info}"'
    else: query =f'insert into {notify_table} (Place, Level, NewDate, NewTime, Info) values ("{Place}", "{Level}", "{date.strftime(r"%Y-%m-%d")}", "{time.strftime("%H:%M %p")}", "{Info}")'
    return db.query(query)

def main():
    tunnel =ngrok.connect(22, 'tcp')
    message +=tunnel.public_url
    send_Notify(infinitydb, 'Notifier', 'Secure-Shell-Ubuntu', 'Info-Normal', message)

    while os.popen('sudo netstat -tupln | grep ssh').read():
        sleep(10)

def sigterm_handler(signal, frame):
    print("SIGTERM received, stopping ngrok...")
    ngrok_process = ngrok.get_ngrok_process()
    if ngrok_process:
        ngrok.kill()
    message ='Ubundu SSH (reconnect): '
    main(message)
    
if __name__ == '__main__':
    infinitydb =Infinitydatabase(os.environ['DB_ADMIN_URL'])
    ngrok.set_auth_token(os.environ['NGROK_AUTHTOKEN'])
    signal.signal(signal.SIGTERM, sigterm_handler)
    message ='Ubundu SSH: '
    main(message)
