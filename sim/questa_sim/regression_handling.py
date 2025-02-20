#-----------------------------------------------------------------------
#Description : Opening a file and searching for a pattern in read mode
#Function Used : search()
#-----------------------------------------------------------------------
a f:
        match = re.search('#',line)
        if match:
            continue

        match = re.search(r'\bUart\w*', line)
        if match:
            reg_list_array.append(match.group(0))
            if debug:
                print(match.group(0))

# Prepare the trace file to record the test names
trace_file_path = "test_names_trace.txt"
with open(trace_file_path, 'a') as trace_file:
    for testname in reg_list_array:
        timestr = time.strftime("%d%m%Y-%H%M%S")
        if debug:
            print("time string : ", timestr)

        test_folder = testname + "_" + timestr

        line = "make simulate test_folder=" + test_folder + " test=" + testname
        if debug:
            print(line)
        
        # Write the test name to the trace file
        trace_file.write(testname + "\n")

        os.system(line)

# print(f"Test names have been traced in {trace_file_path}")
