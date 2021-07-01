import sys, os

if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--execute":
        os.system('powershell.exe .\\restart_service.ps1')
    
    else:
        print("FATAL Unsupported execution mode (expected --execute flag)", file=sys.stderr)
    sys.exit(1)
