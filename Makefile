# ------------------------------------------------
# Makefile for Imgui projects with sdl and Opengl2
# ------------------------------------------------
# TODO(elsuizo: 2016-12-03) add debugg options
# project name (generate executable with this name)
TARGET   = out

COMPILER=g++ -std=c++11

LDLIBS = -lGL -ldl -lGLU `sdl2-config --libs`
CPPFLAGS = `sdl2-config --cflags`

# Directories
SRCDIR   = src
INCDIR   = inc
OBJDIR   = obj
BINDIR   = bin

SOURCES  := $(wildcard $(SRCDIR)/*.cpp)
INCLUDES := $(wildcard $(INCDIR)/*.h)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)
rm       = rm -f


$(BINDIR)/$(TARGET): $(OBJECTS)
	@$(COMPILER) $(CPPFLAGS) $(LDLIBS) $(OBJECTS) -o $@
	@echo "Linking complete!"

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.cpp
	@$(COMPILER) $(CPPFLAGS) $(LDLIBS) -c $< -o $@
	@echo "Compiled "$<" successfully!"

.PHONY: clean
clean:
	@$(rm) $(OBJECTS)
	@echo "Cleanup complete!"

.PHONY: remove
remove: clean
	@$(rm) $(BINDIR)/$(TARGET)
	@echo "Executable removed!"
