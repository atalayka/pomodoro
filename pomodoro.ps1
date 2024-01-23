<#-İsterler-#><#
-Bir çalışma periyodu ve bir dinlenme periyodundan oluşacak
-Çalışma periyodu 45 dakika sürecek
-Dinlenme periyodu 10 dakika sürecek
-Çalışma periyodu bittiğinde dinlenme periyodu başlayacak
-Dinlenme periyodu bittiğinde çalışma periyodu başlayacak
-Periyotlar manuel olarak durdurulmak istenmediğinde sonsuza kadar devam edecek
#><#-İsterler-#>

<#-Sınıflar-#>
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
<#-Sınıflar-#>

<#-Görsel Öğeler-#>
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "P Ø M Ø D Ø R Ø"
$Form.Size = New-Object System.Drawing.Size(300, 300)
$Form.StartPosition = "CenterScreen"

$script:Label = New-Object System.Windows.Forms.Label
$script:Label.Location = New-Object System.Drawing.Size(100, 100)
$script:Label.Size = New-Object System.Drawing.Size(100, 100)
$script:Label.Text = "45:00"
$script:Form.Controls.Add($script:Label)
$script:Label.Font = New-Object System.Drawing.Font("Lucida Console", 20, [System.Drawing.FontStyle]::Bold)

$script:Label2 = New-Object System.Windows.Forms.Label
$script:Label2.Text = "10:00"
$script:Label2.Location = New-Object System.Drawing.Size(100, 100)
$script:Label2.Font = New-Object System.Drawing.Font("Lucida Console", 20, [System.Drawing.FontStyle]::Bold)
$script:Label2.Size = New-Object System.Drawing.Size(100, 100)
$script:Form.Controls.Add($script:Label2)

$script:Label3 = New-Object System.Windows.Forms.Label
$script:Form.Controls.Add($script:Label3)
$script:Label3.Location = New-Object System.Drawing.Size(90, 110)
$script:Label3.Size = New-Object System.Drawing.Size(120, 120)
$script:Label3.Font = New-Object System.Drawing.Font("Lucida Console", 15, [System.Drawing.FontStyle]::Bold )
$script:Label3.ForeColor = "Red"

$script:Label4 = New-Object System.Windows.Forms.Label
$script:Form.Controls.Add($script:Label4)
$script:Label4.Location = New-Object System.Drawing.Size(65, 95)
$script:Label4.Size = New-Object System.Drawing.Size(150, 150)
$script:Label4.Font = New-Object System.Drawing.Font("Lucida Console", 8, [System.Drawing.FontStyle]::Bold )
$script:Label4.ForeColor = "Red"
$Script:Label4.Text = "Toplam Çalışma Süresi"
<#-Görsel Öğeler-#>

<#-Tüm Görsel Öğeleri Kapat-#>
$script:Label.Visible = $false
$script:Label2.Visible = $false
$script:Label3.Visible = $false
$script:Label4.Visible = $false
<#-Tüm Görsel Öğeleri Kapat-#>

<#-Zaman Sayaçları-#>
$script:Timer = New-Object System.Windows.Forms.Timer
$script:Timer.Interval = 1000
$script:CounterSeconds = 59
$script:StudyingTime = 44

$script:Timer2 = New-Object System.Windows.Forms.Timer
$script:Timer2.Interval = 1000
$script:CounterSeconds2 = 59
$script:StudyingTime2 = 09

$script:Timer3 = New-Object System.Windows.Forms.Timer
$script:Timer3.Interval = 1000
$script:Saat = 00
$script:Dakika = 00
$script:Saniye = 00
<#-Zaman Sayaçları-#>

function DersCalismaPeriyodu {
    <#Çalışma Periyodu |Başlangıç#>

    $CalismaPeriyoduMsgBox = [System.Windows.Forms.MessageBox]::Show('Çalışma Vakti! Hazır mısın? :)', 'Çalışma Vakti!', 'YesNo', 'Warning' )
    switch ($CalismaPeriyoduMsgBox) {
        'Yes' {
            $script:Timer.Dispose()
            $script:Timer = [System.Windows.Forms.Timer]::new()
            $script:Timer.Interval = 1000

            <#Çalışma süresi#>
            $script:CounterSeconds = 59
            $script:StudyingTime = 44
            <#Çalışma süresi#>

            $script:Timer.Start()
            $script:Label.Visible = $true

            <#Timer3 Toplam çalışma saati#>
            $script:Timer3.Dispose()
            $script:Timer3 = [System.Windows.Forms.Timer]::new()
            $script:Timer3.Interval = 1000
            $script:Timer3.Start()
            <#Timer3 Toplam çalışma saati#>
        }
        'No' {
            $Form.Close()
        }
    }

    $script:Timer.add_Tick(
        {
            if ($script:CounterSeconds -eq 0) {
                $script:CounterSeconds = 60
                $script:StudyingTime--
            }
            $script:CounterSeconds--

            <#Label$script:Label presentation|start#>
            $script:Label.Text = "{0}:{1}" -f $script:StudyingTime, $script:CounterSeconds

            if ($script:CounterSeconds -lt 10) {
                $script:Label.Text = "{0}:0{1}" -f $script:StudyingTime, $script:CounterSeconds
            }
            if ($script:StudyingTime -lt 10) {
                $script:Label.Text = "0{0}:{1}" -f $script:StudyingTime, $script:CounterSeconds
            }
            if (($script:CounterSeconds -lt 10) -and ($script:StudyingTime -lt 10)) {
                $script:Label.Text = "0{0}:0{1}" -f $script:StudyingTime, $script:CounterSeconds
            }
            <#Label$script:Label presentation|finish#>

            <#Timer Bitişi |Başlangıç#>
            if (($script:CounterSeconds -eq 0) -and ($script:StudyingTime -eq 0)) {
                $script:Label.Visible = $false
                $script:Timer.Stop()
                $script:Timer.Dispose()
                $script:Timer = [System.Windows.Forms.Timer]::new()
                $script:Timer.Interval = 1000

                <#Çalışma süresi#>
                $script:CounterSeconds = 59
                $script:StudyingTime = 44
                <#Çalışma süresi#>
                
                $Form.TopMost = $True

                $script:Label3.Visible = $true
                $script:Label4.Visible = $true

                Start-Sleep -Seconds 1  

                for ($i = 0; $i -lt 3; $i++) {
                    [console]::beep(1000, 150)   
                    Start-Sleep -Milliseconds 20
                    [console]::beep(1000, 150)   
                    Start-Sleep -Seconds 1
                }

                $script:Label3.Visible = $false
                $script:Label4.Visible = $false


                <#Dinlenme Periyoduna Geç#>
                DinlenmePeriyodu
                <#Dinlenme Periyoduna Geç#>
            }  
            <#Timer Bitişi |Başlangıç#>
        })
    <#Çalışma Periyodu |Bitiş#>
    
    <#Genel Toplam Çalışma Saati Hesaplama#>
    $script:Timer3.add_Tick({

            $script:Saniye++

            if ($script:Saniye -eq 59) {
                $script:Saniye = 0
                $script:Dakika++
            }
            if (($script:Dakika -eq 59) -and ($script:Saniye -eq 59)) {
                $script:Saat++
            }

            <#Label 3 gösterimi#> 
            if ($script:Saniye -lt 10) {
                $script:Label3.Text = "{0}:{1}:0{2}" -f $script:Saat, $script:Dakika, $script:Saniye
            }
            if ($script:Dakika -lt 10) {
                $script:Label3.Text = "{0}:0{1}:{2}" -f $script:Saat, $script:Dakika, $script:Saniye
            }
            if ($script:Saat -lt 10) {
                $script:Label3.Text = "0{0}:{1}:{2}" -f $script:Saat, $script:Dakika, $script:Saniye
            }
            if ($script:Saniye -lt 10 -and $script:Dakika -le 10) {
                $script:Label3.Text = "{0}:0{1}:0{2}" -f $script:Saat, $script:Dakika, $script:Saniye
            }
            if ($script:Saniye -lt 10 -and $script:Saat -le 10) {
                $script:Label3.Text = "0{0}:{1}:0{2}" -f $script:Saat, $script:Dakika, $script:Saniye
            }
            if ($script:Dakika -lt 10 -and $script:Saat -le 10) {
                $script:Label3.Text = "0{0}:0{1}:{2}" -f $script:Saat, $script:Dakika, $script:Saniye
            }
            if ($script:Saniye -lt 10 -and $script:Dakika -lt 10 -and $script:Saat -lt 10) {
                $script:Label3.Text = "0{0}:0{1}:0{2}" -f $script:Saat, $script:Dakika, $script:Saniye
            }


            <#Label 3 gösterimi#>
        })
    <#Genel Toplam Çalışma Saati Hesaplama#>

}

function DinlenmePeriyodu {
    <#Dinlenme Periyodu |Başlangıç#>
    $DinlenmePeriyoduMsgBox = [System.Windows.Forms.MessageBox]::Show('Dinlenme Vakti! 10 Dakika dinlenecek misin? :)', 'Dinlenme Vakti!', 'YesNo', 'Warning')
    switch ($DinlenmePeriyoduMsgBox) {

        'Yes' {
            $script:Timer2.Dispose()
            $script:Timer2 = [System.Windows.Forms.Timer]::new()
            $script:Timer2.Interval = 1000

            $script:Timer2.Start()
            $script:Label2.Visible = $true
        }
        'No' {
            $script:Timer.Dispose()
            $script:Timer = [System.Windows.Forms.Timer]::new()
            $script:Timer.Interval = 1000

            $script:Timer.Start()
            $script:Label.Visible = $true

            <#Çalışma süresi#>
            $script:CounterSeconds = 59
            $script:StudyingTime = 44
            <#Çalışma süresi#>

            $script:Timer.add_Tick(
                {
                    if ($script:CounterSeconds -eq 0) {
                        $script:CounterSeconds = 60
                        $script:StudyingTime--
                    }
                    $script:CounterSeconds--

                    <#Label$script:Label presentation|start#>
                    $script:Label.Text = "{0}:{1}" -f $script:StudyingTime, $script:CounterSeconds

                    if ($script:CounterSeconds -lt 10) {
                        $script:Label.Text = "{0}:0{1}" -f $script:StudyingTime, $script:CounterSeconds
                    }
                    if ($script:StudyingTime -lt 10) {
                        $script:Label.Text = "0{0}:{1}" -f $script:StudyingTime, $script:CounterSeconds
                    }
                    if (($script:CounterSeconds -lt 10) -and ($script:StudyingTime -lt 10)) {
                        $script:Label.Text = "0{0}:0{1}" -f $script:StudyingTime, $script:CounterSeconds
                    }
                    <#Label$script:Label presentation|finish#>

                    <#Timer Bitişi |Başlangıç#>
                    if (($script:CounterSeconds -eq 0) -and ($script:StudyingTime -eq 0)) {
                        $script:Label.Visible = $false
                        $script:Timer.Stop()
                        $script:Timer.Dispose()
                        $script:Timer = [System.Windows.Forms.Timer]::new()
                        $script:Timer.Interval = 1000

                        <#Çalışma süresi#>
                        $script:CounterSeconds = 59
                        $script:StudyingTime = 44
                        <#Çalışma süresi#>

                        $Form.TopMost = $True

                        $script:Label3.Visible = $true
                        $script:Label4.Visible = $true
                        start-sleep -Seconds 1

                        for ($i = 0; $i -lt 3; $i++) {
                            [console]::beep(1000, 150)   
                            Start-Sleep -Milliseconds 20
                            [console]::beep(1000, 150)   
                            Start-Sleep -Seconds 1
                        }

                        $script:Label3.Visible = $false
                        $script:Label4.Visible = $false

                        <#Dinlenme Periyoduna Geç#>
                        DinlenmePeriyodu
                        <#Dinlenme Periyoduna Geç#>
                    }  
                    <#Timer Bitişi |Başlangıç#>
                })
            <#Çalışma Periyodu |Bitiş#>
        }
    }

    $script:Timer2.add_Tick(
        {
            if ($script:CounterSeconds2 -eq 0) {
                $script:CounterSeconds2 = 60
                $script:StudyingTime2--
            }
            $script:CounterSeconds2--

            <#Label$script:Label presentation|start#>
            $script:Label2.Text = "{0}:{1}" -f $script:StudyingTime2, $script:CounterSeconds2

            if ($script:CounterSeconds2 -lt 10) {
                $script:Label2.Text = "{0}:0{1}" -f $script:StudyingTime2, $script:CounterSeconds2
            }
            if ($script:StudyingTime2 -lt 10) {
                $script:Label2.Text = "0{0}:{1}" -f $script:StudyingTime2, $script:CounterSeconds2
            }
            if (($script:CounterSeconds2 -lt 10) -and ($script:StudyingTime -lt 10)) {
                $script:Label2.Text = "0{0}:0{1}" -f $script:StudyingTime2, $script:CounterSeconds2
            }
            <#Label$script:Label presentation|finish#>

            <#Timer Bitişi |Başlangıç#>
            if (($script:CounterSeconds2 -eq 0) -and ($script:StudyingTime2 -eq 0)) {
                $script:Label2.Visible = $false
                $script:Timer2.Stop()
                $script:Timer2.Dispose()
                $script:Timer2 = [System.Windows.Forms.Timer]::new()
                $script:Timer2.Interval = 1000

                <#Dinlenme süresi#>
                $script:CounterSeconds2 = 59
                $script:StudyingTime2 = 09
                <#Dinlenme süresi#>

                $script:Label3.Visible = $true
                $script:Label4.Visible = $true

                Start-Sleep -Seconds 1

                for ($i = 0; $i -lt 3; $i++) {
                    [console]::beep(1000, 150)   
                    Start-Sleep -Milliseconds 20
                    [console]::beep(1000, 150)   
                    Start-Sleep -Seconds 1
                }

                $script:Label3.Visible = $false
                $script:Label4.Visible = $false


                <#Çalışma Periyoduna Geç#>
                DersCalismaPeriyodu
                <#Çalışma Periyoduna Geç#>
                
            }  
            <#Timer Bitişi |Başlangıç#>
        })
    <#Dinlenme Periyodu |Bitiş#> 
}

DersCalismaPeriyodu #fonksiyonu çağır.

$Form.ShowDialog()