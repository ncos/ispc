TASK_CXX=../tasksys.cpp
TASK_LIB=-lpthread
TASK_OBJ=objs/tasksys.o

CXX=icc -mmic
CXXFLAGS+=-Iobjs_knc/ -O2 -I../ -I../util  -I./
CC=icc -mmic
CCFLAGS+= -Iobjs_knc/ -O2 -I../ -I../util -I./

LD=icc -mmic

LIBS=-lm $(TASK_LIB) -lstdc++
ISPC=ispc
ISPC_FLAGS+=-O2
ISPC_FLAGS+= --target=$(ISPC_TARGET) --c++-include-file=$(ISPC_INTRINSICS)

ISPC_HEADERS=$(ISPC_SRC:%.ispc=objs_knc/%_ispc.h)
ISPC_OBJ=$(ISPC_SRC:%.ispc=objs_knc/%_ispc.o)
CXX_OBJ=$(CXX_SRC:%.cpp=objs_knc/%.o)
CXX_OBJ+=$(TASK_OBJ)

PROG=$(EXAMPLE)_knc

all: dirs $(PROG)

dirs:
	/bin/mkdir -p objs_knc/

objs_knc/%.cpp objs_knc/%.o objs_knc/%.h: dirs

clean: 
	/bin/rm -rf $(PROG) objs_knc

$(PROG): $(ISPC_OBJ) $(CXX_OBJ) 
	$(LD) -o $@ $^ $(LDFLAGS)

objs_knc/%.o: %.cpp
	$(CXX) $(CXXFLAGS)  -o $@ -c $<

objs_knc/%.o: ../%.cpp
	$(CXX) $(CXXFLAGS)  -o $@ -c $<
objs_knc/%.o: ../../%.cpp
	$(CXX) $(CXXFLAGS)  -o $@ -c $<
objs_knc/%.o: ../../util/%.cpp
	$(CXX) $(CXXFLAGS)  -o $@ -c $<

objs_knc/%_ispc.o: %.ispc
	$(ISPC) $(ISPC_FLAGS) --emit-c++ -o objs_knc/$*_ispc_zmm.cpp -h objs_knc/$*_ispc.h $< 
	$(CXX) $(CXXFLAGS) -o $@ objs_knc/$*_ispc_zmm.cpp  -c

