To use this demo, one shoud:  
1. adjust the parameters  
2. run:
```
make
```

## Set the parameters
### ./Makefile:
1. `NAME`：避免此demo在同一Kubernetes平台运行因为重名而导致失败，需要修改该字段；  
2. `SCHEDULE`：默认是"4 \*/1 \* \* \*"，为每小时的第四分钟启动项目，可以依需求修改；  
其余参数，如非必要无需修改。

### ./manifest/Makefile
1. `GOOD`：在淘宝搜索的关键词；  
2. `CONDITION`：商品名称中的关键字，用于过滤商品；  
3. `SCKEY`：方糖关联的`SCKEY`，推送信息。
4. 价格阈值：在`chk1`和`chk2` targets中通过修改`CHK`字段的值实现，当所关注的商品价格小于`CHK`的字段，即进行消息推送。
默认，只运行`chk1`和`chk2`，容器启动的命令可以通过修改`./manifests/cronjob.yaml.sed`中的`.spec.spec.cotainers.commnad`字段实现。

## Deploy
run:
```
make all
```
