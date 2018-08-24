To use this demo, one shoud:  
1. adjust the parameters  
2. run:
```
make
```

## Set the parameters
### ./Makefile:
1. NAME：避免此demo在同一Kubernetes平台运行因为重名而导致失败，需要修改该字段；  
2. SCHEDULE：默认是"4 \*/1 \* \* \*"，为每小时的第四分钟启动项目，可以依需求修改；  
