local status, impatient = pcall(require, 'impatient')
if not status then
	vim.notify("impatient error")
	return
end

impatient.enable_profile()
