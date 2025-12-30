project "GLFW"
	kind "StaticLib"
	language "C"

	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"glfw_config.h",
		"GLFW/glfw3.h",
		"GLFW/glfw3native.h",
		"src/init.c",
		"src/input.c",
		"src/context.c",
		"src/monitor.c",
		"src/vulkan.c",
		"src/window.c"
	}

	includedirs { "include", "src" }

	filter "system:linux"
		pic "On"

		systemversion "latest"
		staticruntime "On"

		files
		{
			"x11_platform.h",
			"x11_unicode.h",
			"posix_time.h",
			"posix_thread.h",
			"glx_context.h",
			"egl_context.h",
			"osmesa_context.h",
			--
			"src/x11_init.c",
			"src/x11_monitor.c",
			"src/x11_window.c",
			"src/xkb_unicode.c",
			"src/posix_time.c",
			"src/posix_thread.c",
			"src/glx_context.c",
			"src/egl_context.c",
			"src/osmesa_context.c",
			--
			"linux_joystick.h",
			"src/linux_joystick.c"
		}

		defines	{"_GLFW_X11"}
		links { "X11", "Xrandr", "Xi", "Xxf86vm", "Xcursor", "GL", "m", "dl", "pthread" }

	filter "system:windows"
		systemversion "latest"
		staticruntime "On"

		files
		{
			"src/win32_init.c",
			"src/win32_joystick.c",
			"src/win32_monitor.c",
			"src/win32_time.c",
			"src/win32_thread.c",
			"src/win32_window.c",
			"src/wgl_context.c",
			"src/egl_context.c",
			"src/osmesa_context.c"
		}

		defines 
		{ 
			"_GLFW_WIN32",
			"_CRT_SECURE_NO_WARNINGS"
		}

	filter "system:macosx"
		pic "On"
		systemversion "12.0"
		staticruntime "On"

		files
		{
			"cocoa_platform.h",
			"cocoa_joystick.h",
			"posix_thread.h",
			"nsgl_context.h",
			"egl_context.h",
			"osmesa_context.h",
			--
			"src/cocoa_init.m",
			"src/cocoa_joystick.m",
			"src/cocoa_monitor.m",
			"src/cocoa_window.m",
			"src/cocoa_time.c",
			"src/posix_thread.c",
			"src/nsgl_context.m",
			"src/egl_context.c",
			"src/osmesa_context.c"
		}

		defines  { "_GLFW_COCOA" }

		links
		{
			"Cocoa.framework",
			"IOKit.framework",
			"CoreFoundation.framework"
		}

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"