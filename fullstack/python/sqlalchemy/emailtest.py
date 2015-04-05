from sqlalchemy.orm import sessionmaker
from sqlalchemy import *
from sqlalchemy.sql import select

from email import *
Base = declarative_base()

engine = create_engine('oracle+cx_oracle://xtra:5pecial5@dtcd')
metadata = MetaData(bind=engine)
session = sessionmaker(bind=engine)
sess = session()
#print sess.query(Email)

for e in sess.query(Email).filter(Email.cc_id == 112650816179851000):
        print e.email_ad