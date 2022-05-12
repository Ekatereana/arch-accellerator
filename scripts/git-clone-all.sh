#/bin/bash
cd github-mod/

terraform init
TF_VAR_github_token="${github_access_token}" TF_VAR_genereted_repo_name="${generated}" terraform apply


cd ../

mkdir -p push-code



git commit -m "Merge B project as our subdirectory"
git pull -s subtree Bproject master

cd ./push-code
git init
git clone -b "${terraform_branch}" "$terraform"
cd ./terraform
git remote rm origin
rm -rf .git
cd ../
git remote add -f "function" "$function"

git pull "function" "${function_branch}"

git add . 
git commit -m "generated by the terraform + bash scripts"

git push "https://${github_access_token}@github.com/${github_username}/${generated}.git" "HEAD:refs/heads/main"

cd ../

# rm -rvf ./push-code

