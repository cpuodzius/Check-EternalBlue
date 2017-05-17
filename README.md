# Check-EternalBlue
Check if your computer is patched against EternalBlue.

### Local verification (VB script):

 - Run [VerifyEternalBlue.vbs](https://github.com/puodzius/Check-EternalBlue/blob/master/VerifyEternalBlue.vbs) on your Windows computer

### Remote verification (PS scripts):

 - Download [VerifyEternalBlue.ps1](https://github.com/puodzius/Check-EternalBlue/blob/master/VerifyEternalBlue.ps1) and [Logging_Functions.ps1](https://github.com/puodzius/Check-EternalBlue/blob/master/Logging_Functions.ps1) to the same directory
 - Prepare a list of hostnames you want to check
 - Run VerifyEternalBlue.ps1 as follows:
 
 ```sh
 PS > powershell {script_dir}\VerifyEternalBlue.ps1 -InputFile {path_to_hostname_list}
 ```

Writing about EternalBlue:

 * [Check-EternalBlue: Is your PC patched against the WannaCryptor worm vulnerability?](https://www.welivesecurity.com/2017/05/16/check-eternalblue-pc-patched-wannacryptor-worm-vulnerability/)
 
[BRAZUCAS]
 * [Check-EternalBlue: Verifique se o seu PC está protegido contra a vulnerabilidade explorada pelo WannaCry](https://www.welivesecurity.com/br/2017/05/16/check-eternalblue-seu-pc-protegido/)

[/BRAZUCAS]

*IMPORTANT*: EternalBlue is used as a propagation mechanism. Patching the system does not mean that it is protected against the encryption routine. It only means that the system is protected against the "wormness" of recent WannaCry's variant.

Learn more:

  * Countermeasures: https://www.us-cert.gov/ncas/alerts/TA17-132A#solution
  * Microsoft Security Bulletin MS17-010 - Critical: https://technet.microsoft.com/en-us/library/security/ms17-010.aspx
  * Microsoft guidance: https://blogs.technet.microsoft.com/msrc/2017/05/12/customer-guidance-for-wannacrypt-attacks/
  * Tech data: https://gist.github.com/rain-1/989428fa5504f378b993ee6efbc0b168
  * WannaCry's profit: http://howmuchwannacrypaidthehacker.com 

Follow me at [@cpuodzius](https://twitter.com/cpuodzius)
