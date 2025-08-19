Write-Host "------------------------------------------------------------------------" -ForegroundColor Red
Write-Host "                <Host_name>" -ForegroundColor Yellow
Write-Host "------------------------------------------------------------------------" -ForegroundColor Red
Invoke-Command -ComputerName "<Host_name>" -ScriptBlock {
    $clusterGroups = Get-ClusterGroup | Where-Object { $_.GroupType -eq 'VirtualMachine' }
    $clusterNodes = Get-ClusterNode
    $clusterVolume = Get-ClusterSharedVolume 
    $clusterNetworkInt = Get-ClusterNetwork

    # Вывод информации о группах виртуальных машин
    Write-Host "Cluster Roles фермы <Host_name>: " -ForegroundColor Green
    $clusterGroups | Format-Table -AutoSize 

    Write-Host "`nCluster Nodes фермы <Host_name>:" -ForegroundColor Green
    $clusterNodes | Format-Table -AutoSize

    Write-Host "Cluster Volumes фермы <Host_name>:" -ForegroundColor Green
    $clusterVolume | Format-Table -AutoSize

    Write-Host "Cluster сетевые интерфейсы фермы <Host_name>:" -ForegroundColor Green
    $clusterNetworkInt | Format-Table -AutoSize
}
Write-Host "------------------------------------------------------------------------" -ForegroundColor Red
Write-Host "                <Host_name>" -ForegroundColor Green
Write-Host "------------------------------------------------------------------------" -ForegroundColor Red
Write-Host "Статус Hosts в Virtual Machines Manager: " -ForegroundColor Green
Invoke-Command -ComputerName "<Host_name>" -ScriptBlock { Get-SCVMHost | Select-Object Name, VirtualServerState, ClusterNodeStatus, MostRecentTaskUIState, OverallState  | Format-Table -AutoSize  }
Write-Host "Статус VM в Virtual Machines Manager: " -ForegroundColor Green
Invoke-Command -ComputerName "<Host_name>" -ScriptBlock { Get-SCVirtualMachine| Select-Object Name, Status, VirtualMachineState | Format-Table -AutoSize }
Write-Host "Статус Network в Virtual Machines Manager: " -ForegroundColor Green
Invoke-Command -ComputerName "<Host_name>" -ScriptBlock { Get-SCVirtualNetwork | Select-Object VMHost, HighlyAvailable, LogicalSwitch, LogicalSwitchComplianceStatus | Format-Table -AutoSize }
pause