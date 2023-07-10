# Running the application
### 1.1. run (first-time)
```` make first-run full-img-name=docker_acc/img_name:vers````(if you didn't change the vars in tf vars then no changes are expected otherwise follow what's written )
### 1.2. If not for the first time (img is present)
```` make subs-run full-img-name=docker_acc/img_name:vers```` 
### 1.3. if it's the first run but architecture already exists 
```` make get-key-and-apply-infra full-img-name=docker_acc/img_name:vers````

#### 2.0. (Wait untill all services are running, verify by):
```` kubectl get pods -o wide````
##### You should see something similar to this ![img.png](images/img.png)

### 2. Open tunnel in a separate terminal and run and create a topic using UI with 3 partitions
```` make tunnel-control-center````

![img_4.png](images/img_4.png)


![img_3.png](images/img_3.png)

![img_2.png](images/img_2.png)
### 3. Open tunnel in a separate terminal and run(abort tunnel from prev step if necessary)
```` make tunnel-connect````

### 4. Open separate terminal and run
````make submit-connector````




# RESULTS
After you have submitted the job you should see smth like this
![img.png](images/img_10.png)
The topic itself should look like
![img_2.png](images/img_12.png)
![img_1.png](images/img_11.png)