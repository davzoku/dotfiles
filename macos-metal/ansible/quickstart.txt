# TODO: convert to https://github.com/phelipetls/dotfiles/blob/master/install

conda create -n ansible
conda activate ansible
pip install ansible

ansible-playbook playbooks/bootstrap.yml