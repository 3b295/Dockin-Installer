#!/usr/bin/env bash
#
# Copyright (C) @2020 Webank Group Holding Limited
# <p>
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
# in compliance with the License. You may obtain a copy of the License at
# <p>
# http://www.apache.org/licenses/LICENSE-2.0
# <p>
# Unless required by applicable law or agreed to in writing, software distributed under the License
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions and limitations under
# the License.
#

#==============================================================================
#description     :remove kubelet/kubeadm/kubectl v1.16.2.
#author		       :
#linux           :centos7
#user            :root
#comment         :，k8s，masterdelete-node.sh
#                 。
#==============================================================================
# root
if [ $UID -ne 0 ]; then
    echo "Superuser privileges are required to run this script."
    echo "e.g. \"sudo $0\""
    exit 1
fi


kubeadm reset

#
rm -rf /var/lib/cni/
rm -rf /var/lib/kubelet/*
rm -rf /etc/cni/
rm -rf /run/flannel
ifconfig cni0 down
ifconfig flannel.1 down
ifconfig docker0 down
ip link delete cni0
ip link delete flannel.1
##kubelet
systemctl restart kubelet
##docker
systemctl restart docker

systemctl stop kubelet

rm -rf /data/kubernetes/config/kubelet
rm -rf /data/kubernetes/config/kubelet-extra-args

yum remove -y kubeadm
yum remove -y kubelet
yum remove -y kubectl
yum remove -y kubernetes-cni

rm -rf /opt/cni/bin

rm -rf /etc/systemd/system/kubelet*
rm -rf /usr/bin/kubeadm
rm -rf /usr/bin/kubelet
rm -rf /usr/bin/kubectl

rm -rf /bin/kubeadm
rm -rf /bin/kubelet
rm -rf /bin/kubectl