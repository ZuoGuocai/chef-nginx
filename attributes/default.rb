# global
default[:nginx][:workers] = 1
default[:nginx][:worker_conns] = 1024
default[:nginx][:gzip] = 'on'
default[:nginx][:default_vhost][:enable] = true
default[:nginx][:doc_root] = '/var/www'
default[:nginx][:version] = '1.4.1-5.el6.modsec'
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
default[:nginx][:modsecurity][:SecAuditLogType] = 'Concurrent'
default[:nginx][:modsecurity][:SecAuditLog] = '/var/log/nginx/modsec_audit.log'
default[:nginx][:modsecurity][:SecDebugLog] = '/var/log/nginx/modsec_debug.log'
default[:nginx][:modsecurity][:SecDebugLogLevel] = 0
default[:nginx][:modsecurity][:SecUploadDir] = '/var/lib/modsecurity/upload'
default[:nginx][:modsecurity][:SecAuditLogStorageDir] = '/var/lib/modsecurity/audit'

# modsecurity - CRS
default[:nginx][:modsecurity][:crs][:enable] = true
default[:nginx][:modsecurity][:crs][:repo] = 'https://github.com/SpiderLabs/owasp-modsecurity-crs.git'
default[:nginx][:modsecurity][:crs][:version] = '2.2.8'
default[:nginx][:modsecurity][:crs][:SecGeoLookupDb] = '/var/lib/modsecurity/GeoLiteCity.dat'
# Only put the rule name, leave out the extension
default[:nginx][:modsecurity][:crs][:optional_rules] = []
default[:nginx][:modsecurity][:crs][:experimental_rules] = []
default[:nginx][:modsecurity][:crs][:slr_rules] = []
