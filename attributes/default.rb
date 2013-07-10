<<<<<<< HEAD
# global
=======
>>>>>>> 49cf256a8c5abf1758b12311294289d3502b6e59
default[:nginx][:workers] = 1
default[:nginx][:worker_conns] = 1024
default[:nginx][:gzip] = 'on'
default[:nginx][:default_vhost][:enable] = true
default[:nginx][:doc_root] = '/var/www'
<<<<<<< HEAD
default[:nginx][:version] = '1.4.1-3.el6.modsec'
default[:nginx][:configure][:repo] = true

# modsecurity
default[:nginx][:modsecurity][:enable] = true
default[:nginx][:modsecurity][:SecRuleEngine] = 'On'
default[:nginx][:modsecurity][:SecRequestBodyAccess] = 'On'
default[:nginx][:modsecurity][:SecRequestBodyLimit] = 13107200
default[:nginx][:modsecurity][:SecRequestBodyNoFilesLimit] = 131072
default[:nginx][:modsecurity][:SecRequestBodyInMemoryLimit] = 131072
default[:nginx][:modsecurity][:SecRequestBodyLimitAction] = 'Reject'
default[:nginx][:modsecurity][:SecPcreMatchLimit] = 1000
default[:nginx][:modsecurity][:SecPcreMatchLimitRecursion] = 1000
default[:nginx][:modsecurity][:SecResponseBodyAccess] = 'On'
default[:nginx][:modsecurity][:SecResponseBodyMimeType] = 'text/plain text/html text/xml'
default[:nginx][:modsecurity][:SecResponseBodyLimit] = 524288
default[:nginx][:modsecurity][:SecResponseBodyLimitAction] = 'ProcessPartial'
default[:nginx][:modsecurity][:SecTmpDir] = '/tmp/nginx/'
default[:nginx][:modsecurity][:SecDataDir] = '/tmp/nginx/'
default[:nginx][:modsecurity][:SecAuditEngine] = 'RelevantOnly'
default[:nginx][:modsecurity][:SecAuditLogParts] = 'ABIJDEFHZ'
default[:nginx][:modsecurity][:SecAuditLogType] = 'Serial'
default[:nginx][:modsecurity][:SecAuditLog] = '/var/log/nginx/modsec_audit.log'
=======
default[:nginx][:version] = '1.4.1-1.el6.ngx'
>>>>>>> 49cf256a8c5abf1758b12311294289d3502b6e59
