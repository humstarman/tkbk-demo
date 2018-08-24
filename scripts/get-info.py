#!/usr/bin/env python
# -*- coding:UTF-8 -*-
import os
import sys
from optparse import OptionParser
import requests
import re
def parse_opts(parser):
    parser.add_option("-g","--good",action="store",type="string",dest="goods",default="",help="the goods to search")
    parser.add_option("-c","--condition",action="store",type="string",dest="target",default="",help="filtering condition for goods")
    parser.add_option("-d","--depth",action="store",type="int",dest="depth",default="3",help="search depth")
    parser.add_option("-o","--output",action="store",type="string",dest="out",default="",help="the file to store searching results")
    (options,args) = parser.parse_args()
    return options
options = parse_opts(OptionParser(usage="%prog [options]"))
def getHTMLText(url):
    try:
        r = requests.get(url, timeout=30)
        r.raise_for_status()
        r.encoding = r.apparent_encoding
        return r.text
    except:
        return ""
def parsePage(ilt, html):
    try:
        plt = re.findall(r'\"view_price\"\:\"[\d\.]*\"',html)
        tlt = re.findall(r'\"raw_title\"\:\".*?\"',html)
        shop = re.findall(r'\"nick\"\:\".*?\"',html)
        for i in range(len(plt)):
            price = eval(plt[i].split(':')[1])
            title = eval(tlt[i].split(':')[1])
            try:
                shop = eval(shop[i].split(':')[1])
            except:
                shop = "unkown"
            if options.target != "":
                if options.target in title:
                    ilt.append([price , title, shop])
            else:
                ilt.append([price , title, shop])
    except:
        print("")
def printGoodsList(ilt):
    with open(options.out,"w") as f:
        tplt = "{:4}\t{:8}\t{:16}\t{:16}"
        print(tplt.format("序号", "价格", "商品名称","店名"))
        f.write(tplt.format("序号", "价格", "商品名称","店名"))
        f.writelines("\n")
        count = 0
        for g in ilt:
            count = count + 1
            print(tplt.format(count, g[0], g[1], g[2]))
            f.write(tplt.format(count, g[0], g[1], g[2]))
            f.writelines("\n")
def main():
    goods = options.goods 
    depth = options.depth 
    start_url = 'https://s.taobao.com/search?q=' + goods
    infoList = []
    for i in range(depth):
        try:
            url = start_url + '&s=' + str(44*i)
            html = getHTMLText(url)
            parsePage(infoList, html)
        except:
            continue
    printGoodsList(infoList)
if __name__ == "__main__":
    main()
