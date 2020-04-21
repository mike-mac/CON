
###################################################
#VPN
#Please check if file exists on following paths
#[string]$vpncliAbsolutePath = 'C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\vpncli.exe'
[string]$vpnuiAbsolutePath  = 'C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe'

#Start-Process -WindowStyle Minimized -FilePath $vpncliAbsolutePath -ArgumentList "connect vpnaccess.utah.edu"
Start-Process -WindowStyle Minimized -FilePath $vpnuiAbsolutePath 


# HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe" -force
New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe' -name "ShowInActionCenter" -value 1;
    

$app = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]

$Template = [Windows.UI.Notifications.ToastTemplateType]::ToastImageAndText01

#Gets the Template XML so we can manipulate the values
[xml]$ToastTemplate = ([Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent($Template).GetXml())

[xml]$ToastTemplate = @"
<toast launch="app-defined-string">
  <visual>
    <binding template="ToastGeneric">
      <text>CON IT VPN Reminder</text>

      <text>To receive important updates and software, please connect to Cisco Anyconnect VPN at leaset once a week. VPNACCESS.UTAH.EDU</text>
    </binding>
  </visual>
  <actions>
    <action activationType="background" content="Close" arguments="later"/>
  </actions>
</toast>
"@

$ToastXml = New-Object -TypeName Windows.Data.Xml.Dom.XmlDocument
$ToastXml.LoadXml($ToastTemplate.OuterXml)

$notify = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($app)

$notify.Show($ToastXml)

# SIG # Begin signature block
# MIIOTwYJKoZIhvcNAQcCoIIOQDCCDjwCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU0aHGVxUujLaGgHRFl2SwhGO3
# QYuggguHMIIFlDCCBHygAwIBAgIQK9JmIalbTqdMCBt2RR7EAzANBgkqhkiG9w0B
# AQsFADB8MQswCQYDVQQGEwJVUzELMAkGA1UECBMCTUkxEjAQBgNVBAcTCUFubiBB
# cmJvcjESMBAGA1UEChMJSW50ZXJuZXQyMREwDwYDVQQLEwhJbkNvbW1vbjElMCMG
# A1UEAxMcSW5Db21tb24gUlNBIENvZGUgU2lnbmluZyBDQTAeFw0xOTA2MjYwMDAw
# MDBaFw0yMjA2MjUyMzU5NTlaMIGyMQswCQYDVQQGEwJVUzEOMAwGA1UEEQwFODQx
# MTIxDTALBgNVBAgMBFV0YWgxFzAVBgNVBAcMDlNhbHQgTGFrZSBDaXR5MR4wHAYD
# VQQJDBUyMDEgUHJlc2lkZW50cyBDaXJjbGUxGzAZBgNVBAoMElVuaXZlcnNpdHkg
# b2YgVXRhaDERMA8GA1UECwwIVW9mVVBsdXMxGzAZBgNVBAMMElVuaXZlcnNpdHkg
# b2YgVXRhaDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAPIpNDjFs8Hk
# vWY8dyiZNxaGSBklvr3AtAZV4ms/oBCXNdIwgjKDphDS0P46Ak2P6D5wHzWjoC9o
# 5jTkygwVsWZFJxekeXuJYsjMV86jqX6UhUXqm+e6XMeqNUKGnFtUgy1fhaFTxC53
# jTISh1JMkWxU5NgQfPdhIoo2dmY56vPvuGrTkhNxL6chdcD2MnzalmMMHJgxESOB
# HlXPMom9/Xjdif90ngbt20WGe6abaIrPeNkO5QDeOxapL3/FUv1R52F7ZAPkkRSC
# aHhTwB3xDUcEoIZbGYAZOoMj0v6xZlSHCMQb+3wMgnxmh9rsVPLZlRt5kqh/Qca4
# +PojXPD4dFkCAwEAAaOCAdkwggHVMB8GA1UdIwQYMBaAFK41Ixf//wY9nFDgjCRl
# Mx5wEIiiMB0GA1UdDgQWBBRwUzndPWQFnEkBUJeYQf3L17QOpzAOBgNVHQ8BAf8E
# BAMCB4AwDAYDVR0TAQH/BAIwADATBgNVHSUEDDAKBggrBgEFBQcDAzARBglghkgB
# hvhCAQEEBAMCBBAwZgYDVR0gBF8wXTBbBgwrBgEEAa4jAQQDAgEwSzBJBggrBgEF
# BQcCARY9aHR0cHM6Ly93d3cuaW5jb21tb24ub3JnL2NlcnQvcmVwb3NpdG9yeS9j
# cHNfY29kZV9zaWduaW5nLnBkZjBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
# LmluY29tbW9uLXJzYS5vcmcvSW5Db21tb25SU0FDb2RlU2lnbmluZ0NBLmNybDB+
# BggrBgEFBQcBAQRyMHAwRAYIKwYBBQUHMAKGOGh0dHA6Ly9jcnQuaW5jb21tb24t
# cnNhLm9yZy9JbkNvbW1vblJTQUNvZGVTaWduaW5nQ0EuY3J0MCgGCCsGAQUFBzAB
# hhxodHRwOi8vb2NzcC5pbmNvbW1vbi1yc2Eub3JnMBoGA1UdEQQTMBGBD2Nvbi1p
# dEB1dGFoLmVkdTANBgkqhkiG9w0BAQsFAAOCAQEAsvN7BbCsZhiiTO6ZtH06TWoE
# j9TERW21tl0deI8piN0MX7mm9Q/iSw1qc7XlxgMAWYN1l32EownLtnlW5Y4mFnD/
# m+akDqUzVRevKQLHPKALw7Mcq036Brb7Up00eHw/LA5H2ePq/6Afz+RdvZyNOHV/
# +9cTdELvjD9cB9Uy+dnq/MBQBKOVzjd+4Q/Usu98DLP6qb2RJl6D77t6CrMHIn28
# 079LSL7dt3Ab3mV7E+y+blf1Wj/LrYKsVDDYLmbmTdBDVrT+lZkdk62s/a6WmJLs
# rvdoaKSYqWE+CmmyB85cPfeVlc9Ae8uXRasD/SpzG5kJqOnZ+a/quSI+xcaVajCC
# BeswggPToAMCAQICEGXh4uPV3lBFhfMmJIAF4tQwDQYJKoZIhvcNAQENBQAwgYgx
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJz
# ZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQD
# EyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTE0MDkx
# OTAwMDAwMFoXDTI0MDkxODIzNTk1OVowfDELMAkGA1UEBhMCVVMxCzAJBgNVBAgT
# Ak1JMRIwEAYDVQQHEwlBbm4gQXJib3IxEjAQBgNVBAoTCUludGVybmV0MjERMA8G
# A1UECxMISW5Db21tb24xJTAjBgNVBAMTHEluQ29tbW9uIFJTQSBDb2RlIFNpZ25p
# bmcgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAoC+LHnq7anWs
# +D7co7o5Isrzo3bkv30wJ+a605gyViNcBoaXDYDo7aKBNesL9l5+qT5oc/2d1Gd5
# zqrqaLcZ2xx2OlmHXV6Zx6GyuKmEcwzMq4dGHGrH7zklvqfd2iw1cDYdIi4gO93j
# HA4/NJ/lff5VgFsGfIJXhFXzOPvyDDapuV6yxYFHI30SgaDAASg+A/k4l6OtAvIC
# aP3VAav11VFNUNMXIkblcxjgOuQ3d1HInn1Sik+A3Ca5wEzK/FH6EAkRelcqc8Tg
# ISpswlS9HD6D+FupLPH623jP2YmabaP/Dac/fkxWI9YJvuGlHYsHxb/j31iq76Sv
# gssF+AoJAgMBAAGjggFaMIIBVjAfBgNVHSMEGDAWgBRTeb9aqitKz1SA4dibwJ3y
# sgNmyzAdBgNVHQ4EFgQUrjUjF///Bj2cUOCMJGUzHnAQiKIwDgYDVR0PAQH/BAQD
# AgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwEwYDVR0lBAwwCgYIKwYBBQUHAwMwEQYD
# VR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNl
# cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNy
# bDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRy
# dXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZ
# aHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQ0FAAOCAgEARiy2
# f2pOJWa9nGqmqtCevQ+uTjX88DgnwcedBMmCNNuG4RP3wZaNMEQT0jXtefdXXJOm
# Eldtq3mXwSZk38lcy8M2om2TI6HbqjACa+q4wIXWkqJBbK4MOWXFH0wQKnrEXjCc
# fUxyzhZ4s6tA/L4LmRYTmCD/srpz0bVU3AuSX+mj05E+WPEop4WE+D35OLcnMcjF
# bst3KWN99xxaK40VHnX8EkcBkipQPDcuyt1hbOCDjHTq2Ay84R/SchN6WkVPGpW8
# y0mGc59lul1dlDmjVOynF9MRU5ACynTkdQ0JfKHOeVUuvQlo2Qzt52CTn3OZ1NtI
# Z0yrxm267pXKuK86UxI9aZrLkyO/BPO42itvAG/QMv7tzJkGns1hmi74OgZ3WUVk
# 3SNTkixAqCbf7TSmecnrtyt0XB/P/xurcyFOIo5YRvTgVPc5lWn6PO9oKEdYtDyB
# sI5GAKVpmrUfdqojsl5GRYQQSnpO/hYBWyv+LsuhdTvaA5vwIDM8WrAjgTFx2vGn
# Qjg5dsQIeUOpTixMierCUzCh+bF47i73jX3qoiolCX7xLKSXTpWS2oy7HzgjDdlA
# sfTwnwton5YNTJxzg6NjrUjsUbEIORtJB/eeld5EWbQgGfwaJb5NEOTonZckUtYS
# 1VmaFugWUEuhSWodQIq7RA6FT/4AQ6qdj3yPbNExggIyMIICLgIBATCBkDB8MQsw
# CQYDVQQGEwJVUzELMAkGA1UECBMCTUkxEjAQBgNVBAcTCUFubiBBcmJvcjESMBAG
# A1UEChMJSW50ZXJuZXQyMREwDwYDVQQLEwhJbkNvbW1vbjElMCMGA1UEAxMcSW5D
# b21tb24gUlNBIENvZGUgU2lnbmluZyBDQQIQK9JmIalbTqdMCBt2RR7EAzAJBgUr
# DgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMx
# DAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkq
# hkiG9w0BCQQxFgQU5V7rxJ/UjSm7d8Nlgz4oT1qdoWcwDQYJKoZIhvcNAQEBBQAE
# ggEA46Rxid2J6F3K4SPKE1LPZhs5nv11a2jQ5TBbsMsKkdzBYtt7SGm/vnfkkhl9
# wqvzH1T5O5HIoimiYSlv8hSLdOXzEjlIgZ41+3UDxR7N3aZdEAhjrXMcM5e9UfL5
# l5w9JJXZ28Btm6x1uypa2Mk5+0aXMjCy23CNL55YEOMKG/ZBETCdjX6LF7MvXywf
# bjVsUySkJDU8lDCj1ZPr1jF4O3QPjRlO3bmLQVEBvq9Ay9oYNw9ktGSTR+DmOeH/
# CmUt81Byo41G65Jk5zb2JesNPAgfZQw+BsaZcevrqGG6NK3HXUUAzF9GX0FGI6Mq
# SE5Dbzq5p3wEtdCuQ/kKzlpr1w==
# SIG # End signature block
