TASK_NUM_MIN = 1
TASK_NUM_MAX = 20
task_numbers := $(shell seq $(TASK_NUM_MIN) $(TASK_NUM_MAX))
task_targets := $(addprefix test, $(task_numbers))

CODE_FILE = Lab[0-9][0-9]Code.py
TEST_FILE = Lab[0-9][0-9]Tests.py

PYTEST_FLAGS = -W ignore -v
PYTEST_COMMAND = py.test $(PYTEST_FLAGS)



.PHONY: testall test
testall test: $(TEST_FILE) $(CODE_FILE)
	$(PYTEST_COMMAND) $(TEST_FILE)

.PHONY: testcustom
testcustom: $(CODE_FILE)
	$(PYTEST_COMMAND) $(CODE_FILE)
	
.PHONY: testeverything
testeverything: $(TEST_FILE) $(CODE_FILE)
	$(PYTEST_COMMAND) $(TEST_FILE)
	$(PYTEST_COMMAND) $(CODE_FILE)

.PHONY: $(task_targets)
$(task_targets): test%: $(TEST_FILE)
	$(PYTEST_COMMAND) $^ -m task$*

.PHONY: cov-report
cov-report: $(TEST_FILE) $(CODE_FILE)
	$(PYTEST_COMMAND) --cov-report html --cov $(basename $(wildcard $(CODE_FILE)))  $(TEST_FILE)

.PHONY: help
.SILENT: help
help:
	echo "\nPET-Exercises Makefile Usage:"
	echo "\tmake [cmd]"
	echo "\tcmd:"
	echo "\t\ttestall: Test all tasks against provided tests"
	echo "\t\ttestcustom: Test against your own tests"
	echo "\t\ttesteverything: Test against provided and own tests"
	echo "\t\ttestN: Test against tests provided for task N"
	echo "\t\tcov-report: Generate coverage report"
	
