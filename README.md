# rh-account-access

Access IBM Cloud Account

## Create an OpenShift cluster

1. To create a single zone cluster with 2 workers nodes

    ```sh
    ibmcloud ks cluster create vpc-gen2 \
    --name my-openshift-cluster \
    --zone eu-de-1 \
    --vpc-id r010-741c4741-827a-466e-bb55-cf911c78b6e3 \
    --subnet-id 02b7-c0841b22-f187-499d-8013-3cb38aae12ba \
    --flavor bx2.4x16 \
    --workers 2 \
    --kube-version 4.17.4_openshift \
    --cos-instance crn:v1:bluemix:public:cloud-object-storage:global:a/8361e44f30ef4519bf3272a50c2008b6:ee7986d3-f9ab-404c-a880-2763ea3ce29c::
    ```

1. To create a multi zone cluster with 3 workers

    ```sh
    ibmcloud ks cluster create vpc-gen2 \
    --name my-openshift-cluster \
    --zone eu-de-1 \
    --vpc-id r010-741c4741-827a-466e-bb55-cf911c78b6e3 \
    --subnet-id 02b7-c0841b22-f187-499d-8013-3cb38aae12ba \
    --flavor bx2.4x16 \
    --workers 2 \
    --kube-version 4.17.4_openshift \
    --cos-instance crn:v1:bluemix:public:cloud-object-storage:global:a/8361e44f30ef4519bf3272a50c2008b6:ee7986d3-f9ab-404c-a880-2763ea3ce29c::
    ```


## Resources

