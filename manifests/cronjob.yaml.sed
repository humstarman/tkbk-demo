apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: {{.name}} 
  namespace: {{.namespace}} 
spec:
  schedule: "{{.schedule}}"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: {{.name}} 
            image: {{.image}} 
            imagePullPolicy: {{.image.pull.policy}}
            command:
              - /bin/sh
              - -c
              - make chk1; make chk2 
          restartPolicy: OnFailure
