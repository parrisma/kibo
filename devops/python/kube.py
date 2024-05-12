import argparse
from kubernetes import client, config


class Kube:
    __parser = argparse.ArgumentParser(
        description='Kibo Kubernetes DevOps Manager')

    def __init__(self):
        # Bootstrap Kubernetes Environment
        config.load_kube_config()
        self.v1 = client.CoreV1Api()

        # Add supported argument
        parser.add_argument('--namespace',
                            default="kibo",
                            help='The Kubernetes namespace to use')
        args = vars(parser.parse_args())

    def list_pods(self):
        print("Listing pods with their IPs:")
        ret = self.v1.list_pod_for_all_namespaces(watch=False)
        for i in ret.items:
            print("%s\t%s\t%s" %
                  (i.status.pod_ip, i.metadata.namespace, i.metadata.name))
