from sqlalchemy import *

from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
class Email(Base):
        __tablename__ = 'email'
        __table_args__ = {'schema' : 'cc3'}
        dlr_cd = Column(Integer, primary_key=True)
        cc_id = Column(Integer, primary_key=True)
        email_id = Column(Integer, primary_key=True)
        email_typ_cd = Column(String)
        email_ad = Column(String)
        created_by_user_cd = Column(Integer)
        created_ts = Column(Date)
        updtd_ts = Column(Date)
        updtd_by_user_cd = Column(Integer)