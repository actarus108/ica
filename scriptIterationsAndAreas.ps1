$organizationUrl = Read-Host "Please enter the url of the Organisation Azure DevOps Account (ex : https://dev.azure.com/monOrganisation) "
$projectName = Read-Host "Please enter the name of the Azure DevOps Project "

# Paramétrage des zones - Niveau Projet
az boards area project create --org $organizationUrl -p $projectName --name "Canaux de vente" --path "\$projectName\Area"
az boards area project create --org $organizationUrl -p $projectName --name "Application Mobile" --path "\$projectName\Area\Canaux de vente"
az boards area project create --org $organizationUrl -p $projectName --name "Android" --path "\$projectName\Area\Canaux de vente\Application Mobile"
az boards area project create --org $organizationUrl -p $projectName --name "iOS" --path "\$projectName\Area\Canaux de vente\Application Mobile"
az boards area project create --org $organizationUrl -p $projectName --name "Site internet" --path "\$projectName\Area\Canaux de vente"
az boards area project create --org $organizationUrl -p $projectName --name "Catalogue Produit" --path "\$projectName\Area"
az boards area project create --org $organizationUrl -p $projectName --name "Facturation" --path "\$projectName\Area"
az boards area project create --org $organizationUrl -p $projectName --name "Service Client" --path "\$projectName\Area"
az boards area project create --org $organizationUrl -p $projectName --name "Support" --path "\$projectName\Area"

# Paramétrage des itérations - Niveau Projet
az boards iteration project update --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Iteration 1" --name "Release 1"
az boards iteration project update --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Iteration 2" --name "Release 2"
az boards iteration project update --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Iteration 3" --name "Release 3"
az boards iteration project create --org $organizationUrl -p $projectName --path "\$projectName\Iteration" --name "Futur"

az boards iteration project create --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 1" --name "Sprint 1" --start-date "2021-11-01" --finish-date "2021-11-12"
az boards iteration project create --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 1" --name "Sprint 2" --start-date "2021-11-15" --finish-date "2021-11-26"
az boards iteration project create --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 1" --name "Sprint 3" --start-date "2021-11-29" --finish-date "2021-12-10"

az boards iteration project create --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 2" --name "Sprint 4" --start-date "2021-12-13" --finish-date "2021-12-24"
az boards iteration project create --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 2" --name "Sprint 5" --start-date "2021-12-27" --finish-date "2022-01-07"
az boards iteration project create --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 2" --name "Sprint 6" --start-date "2022-01-10" --finish-date "2022-01-21"

# Paramétrage des zones - Niveau Equipe - Equipe de base
$teamId=(az devops team list --org $organizationUrl --project $projectName --query "[?contains(name, '$projectName')].{id:id}" -o tsv)
az boards area team update --org $organizationUrl -p $projectName --team $teamId --path "\$projectName\Area" --include-sub-areas true

# Paramétrage des itérations - Niveau Equipe - Equipe de base
$futurIdentifier=(az boards iteration project list --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Futur" --query '{id:identifier}' -o tsv)
az boards iteration team set-default-iteration --org $organizationUrl -p $projectName --team $teamId --id $futurIdentifier

$release1Identifier=(az boards iteration project list --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 1" --query '{id:identifier}' -o tsv)
az boards iteration team remove --org $organizationUrl -p $projectName --team $teamId --id $release1Identifier

$release2Identifier=(az boards iteration project list --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 2" --query '{id:identifier}' -o tsv)
az boards iteration team remove --org $organizationUrl -p $projectName --team $teamId --id $release2Identifier

$release3Identifier=(az boards iteration project list --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 3" --query '{id:identifier}' -o tsv)
az boards iteration team remove --org $organizationUrl -p $projectName --team $teamId --id $release3Identifier

$sprint1Identifier=(az boards iteration project list --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 1\Sprint 1" --query '{id:identifier}' -o tsv)
az boards iteration team add --org $organizationUrl -p $projectName --team $teamId --id $sprint1Identifier

$sprint2Identifier=(az boards iteration project list --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 1\Sprint 2" --query '{id:identifier}' -o tsv)
az boards iteration team add --org $organizationUrl -p $projectName --team $teamId --id $sprint2Identifier

$sprint3Identifier=(az boards iteration project list --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 1\Sprint 3" --query '{id:identifier}' -o tsv)
az boards iteration team add --org $organizationUrl -p $projectName --team $teamId --id $sprint3Identifier

$sprint4Identifier=(az boards iteration project list --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 2\Sprint 4" --query '{id:identifier}' -o tsv)
az boards iteration team add --org $organizationUrl -p $projectName --team $teamId --id $sprint4Identifier

$sprint5Identifier=(az boards iteration project list --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 2\Sprint 5" --query '{id:identifier}' -o tsv)
az boards iteration team add --org $organizationUrl -p $projectName --team $teamId --id $sprint5Identifier

$sprint6Identifier=(az boards iteration project list --org $organizationUrl -p $projectName --path "\$projectName\Iteration\Release 2\Sprint 6" --query '{id:identifier}' -o tsv)
az boards iteration team add --org $organizationUrl -p $projectName --team $teamId --id $sprint6Identifier
