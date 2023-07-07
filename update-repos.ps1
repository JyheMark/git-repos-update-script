$workingDirectory = $pwd;
$directories = @(Get-ChildItem -Directory)

function UpdateRepos {
    Write-Host "Updating repos..." -BackgroundColor Magenta;

    foreach ($directory in $directories) {
        Set-Location $directory;
    
        $contents = @(Get-ChildItem -Force -Filter ".git");
    
        if ($contents.Length -ne 1) {
            Write-Host "Skipping $directory" -ForegroundColor Yellow;
            Set-Location $workingDirectory;
            continue;
        }
    
        Write-Host "Updating $directory" -ForegroundColor Green;
    
        $currentBranch = git branch --show-current;
        
        if ($currentBranch -eq "master"){
            Write-Host "Already on master" -ForegroundColor Yellow;
            PullAndPrune;
        }
        else {
            Write-Host "Switching to master" -ForegroundColor Yellow;
            git checkout master;
            PullAndPrune;
            Write-Host "Switching back to $currentBranch" -ForegroundColor Yellow;
            git checkout $currentBranch;
        }
    
        Set-Location $workingDirectory;
    }
    
    Write-Host "Updates complete" -BackgroundColor Magenta;
}

function PullAndPrune {
    git pull;
    git fetch -p;    
}

UpdateRepos;