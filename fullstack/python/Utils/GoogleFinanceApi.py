__author__ = 'rakesh.varma'
import urllib2
import json
import time
import texttable as tt

class GoogleFinanceApi:
    def __init__(self):
        self.prefix = "http://google.com/finance/info?client=ig&q="
        self.tab = tt.Texttable()
        self.tab.set_cols_width([15, 15, 15, 15])
        self.tab.header(["Symbol", "Price", "Change", "Change %"])

    def getQuotes(self, stocklist):
        url = self.prefix
        for stock in stocklist:
            url = url + stock + ','
        u = urllib2.urlopen(url)
        content = u.read()
        obj = json.loads(content[3:])
        return obj

    def printQuotes(self, quotes):
        for quote in quotes:
            self.tab.add_row([quote['t'], quote['l'], quote['c'], quote['cp']])
        print self.tab.draw()


def main():
    stocklist = ['TRAK', 'GOOG', 'AAPL', 'CRM', 'POT', 'AMZN', 'BEAV', 'DIS', 'CELG', 'HOT', 'FCX', 'QCOM']
    c = GoogleFinanceApi()
    quotes = c.getQuotes(stocklist)
    c.printQuotes(quotes)

if __name__ == "__main__":
    main()