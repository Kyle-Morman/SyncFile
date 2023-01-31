$Source = "C:\Users\Veteran\Desktop\Source Directory\"
$Destination = "C:\Users\Veteran\Desktop\Target Directory\"
Add-Type -AssemblyName System.Windows.Forms

$Watcher = New-Object System.IO.FileSystemWatcher
$Watcher.Path = $Source
$Watcher.Filter = "*.*"
$Watcher.IncludeSubdirectories = $false
$Watcher.EnableRaisingEvents = $true

$Action = {
    $Path = $Event.SourceEventArgs.FullPath
    $Name = $Event.SourceEventArgs.Name
    $Dest = $Destination + "\" + $Name
    Copy-Item $Path $Dest
}

Register-ObjectEvent $Watcher "Created" -Action $Action

$Form = New-Object System.Windows.Forms.Form
$Form.Size = New-Object System.Drawing.Size(700,150)
$Form.Text = "SyncFile Status"

$Label = New-Object System.Windows.Forms.Label
$Label.AutoSize = $true
$Label.Location = New-Object System.Drawing.Point(10,10)
$Label.Text = "Active"
$Label.Font = New-Object System.Drawing.Font("Arial",12)

$Form.Controls.Add($Label)
$Form.ShowDialog()
