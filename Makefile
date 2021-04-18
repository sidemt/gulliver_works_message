include .env
export

# ENV
DC = COMPOSE_FILE=docker-compose.yml docker-compose
DC_APP = $(DC) exec app
RAILS_C = $(DC_APP) rails

# GCP ENV
export GOOGLE_CREDENTIALS

# ファイルバリデーション
.env:
	@echo "Need .env file in root directory"
	@echo "You can refer .env.sample"
	@exit 1
check-files: .env

# コンテナ操作コマンド
.PHONY: bundle up build_up down logs clean
build: check-files
	$(DC) build
up: check-files
	$(DC) up -d
build_up: check-files
	$(DC) up -d --build
restart: check-files
	$(DC) restart
force_restart: check-files
	@make down
	@make build_up
down:
	$(DC) down
logs:
	$(DC) logs -f
attach_app:
	@echo "Attaching app..."
	@echo "Ctrl + P, Ctrl + Q to be detach."
	@docker attach $(shell $(DC) ps -q app)

# bundle関連コマンド
.PHONY: bundle_install bundle_remove
bundle_install: check-files
	@$(DC_APP) bundle install -j 4
bundle_remove:
	@$(DC_APP) gem uninstall -aIx
	@make bundle_install

rails_env_check:
	@$(eval MAKE_RAILS_ENV := $(shell read -p "RAILS_ENV? (development, test): " RENV; echo $$RENV))
	@echo "run command in $(MAKE_RAILS_ENV)"

# rails関係コマンド
.PHONY: rails_c rails_routes rspec rubocop rubocop_a erd
rails_c: check-files rails_env_check
	@$(RAILS_C) console
rails_routes: check-files
	@$(RAILS_C) routes
rspec: check-files
	@$(DC) exec -e DB_NAME=coadmap_test -e RAILS_ENV=test app bundle exec rspec
rubocop: check-files
	@$(DC_APP) bundle exec rubocop
rubocop_a: check-files
	@$(DC_APP) bundle exec rubocop -a
erd: check-files
	@$(DC_APP) bundle exec erd
test:
	@make rspec

# rails generatorコマンド
.PHONY: rails_g_model rails_g_controller rails_g_migration
buf_model_name:
	@$(eval MODEL_NAME := $(shell read -p "Input model name: " BUF; echo $$BUF))

buf_controller_name:
	@$(eval CONTROLLER_NAME := $(shell read -p "Input controller name: " BUF; echo $$BUF))

buf_migrate_label:
	@$(eval MIGRATE_LABEL := $(shell read -p "Input action and class label(like XxxYyy): " BUF; echo $$BUF))

rails_g_model: buf_model_name
	@$(RAILS_C) g model $(MODEL_NAME)

rails_g_controller: buf_controller_name
	@$(RAILS_C) g controller $(CONTROLLER_NAME)

rails_g_migration: buf_migrate_label
	@$(RAILS_C) g migration $(MIGRATE_LABEL)

# DB関連コマンド
.PHONY: db_create db_migrate db_seed
db_set_environ:
	@$(RAILS_C) db:environment:set RAILS_ENV=$(RAILS_ENV)
db_create: check-files
	@$(RAILS_C) db:create
db_migrate: check-files rails_env_check
	@$(RAILS_C) db:migrate RAILS_ENV=$(MAKE_RAILS_ENV)
db_seed: check-files
	@$(RAILS_C) db:seed
db_migrate_seed: check-files
	@$(RAILS_C) db:migrate db:seed
db_drop: check-files
	@$(RAILS_C) db:drop
db_migrate_reset: check-files
	@$(RAILS_C) db:migrate:reset
db_rollback: check-files rails_env_check
	@$(RAILS_C) db:rollback RAILS_ENV=$(MAKE_RAILS_ENV)
db_reset: check-files
	@$(RAILS_C) db:reset

# Terraform関連コマンド
.PHONY: terraform_init terraform_plan terraform_apply terraform_destroy terraform_fmt
terraform_env_check:
	@$(eval TERRAFORM_ENV := $(shell read -p "ENV? (prd or stg): " ENV; echo $$ENV))
	@echo "run command in $(TERRAFORM_ENV)"
terraform_init: terraform_env_check
	@${TF_CD} && terraform init
terraform_plan: terraform_env_check
	@${TF_CD} && terraform plan
terraform_apply: terraform_env_check
	@${TF_CD} && terraform apply
terraform_destroy: terraform_env_check
	@${TF_CD} && terraform destroy
terraform_fmt:
	@cd ./terraform && terraform fmt -recursive

