Install prometheus and grafana with custom dashboard for frontend application

helm install prom prometheus/ \
--set-file extraScrapeConfigs=extraScrapeConfigs.yaml \
--set-file grafana.dashboards.default.front.json=dashboardJson.json

----------------------------------------------------------------------------------

kubectl apply -f dashboardJson.yaml
helm install prom prometheus/ \
--set-file extraScrapeConfigs=extraScrapeConfigs.yaml

----------------------------------------------------------------------------------
Install frontend with traefik ingerss

helm install front front/ 
helm install traefik -n kube-system traefik/
