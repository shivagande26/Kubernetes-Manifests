Container states:
Waiting state - if any pre-processes need to be done before starting the container in this pre-processing state the container will be in waiting state. Eg: Pulling the image.
Running state - When the container is successfully running it is in running phase.
Terminated state - When container task is completed successfully then container will go to terminated phase.

Pod phases:
pending phase - The pod is accepted by K8S and for some reason the pod is unable to come to running state.
Running phase -  The pod is bound to a node and all containers in a pod are running properly.
Succeeded/Completed phase - All container in a pod are completed successfully.
Failed/Error phase - All containers in a pod are terminated or atleast one container in a pod is terminated in failure.
Unknown phase - For some reason the state of the pod unable to identify. When worker node looses connection with master.


Restart Policies:
Always
Never
OnFailure