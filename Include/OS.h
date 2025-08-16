#pragma once
#include <string>
#include <cstdlib>
#if defined(__APPLE__)
#include <mach/mach.h>
#endif
#include <cstdint>
#include <stdlib.h>

#if defined(_MSC_VER)
#include <windows.h>
#endif

#if defined(__GNUG__)
#include <unistd.h>
#endif

class OS
{
public:

    static std::string GetComputerName(void)
    {
        std::string computer_name;
        const size_t cn_len = 256;
        char cn[cn_len] = { '\0' };

#if defined(_MSC_VER)
        size_t cn_len_ret;

        if (getenv_s(&cn_len_ret, cn, cn_len * sizeof(char), "COMPUTERNAME") == 0)
            computer_name = cn;

#elif defined(__GNUG__)
        if (gethostname(cn, cn_len) == 0)
            computer_name = cn;

#else
#error Unexpected target in OS::GetComputerName()
#endif

        return computer_name;
    }

    static void AlignedFree(void* p)
    {
#if defined(_MSC_VER)
            _aligned_free(p);
#elif defined(__GNUG__)
            free(p);
#else
#error Unexpected target in OS::AlignedFree()
#endif
    }

    static void* AlignedMalloc(size_t mem_size, size_t mem_alignment)
    {
        void* p;
#if defined(_MSC_VER)
        p = _aligned_malloc(mem_size, mem_alignment);
#elif defined(__GNUG__)
        p = aligned_alloc(mem_alignment, mem_size);
#else
#error Unexpected target in OS::AlignedMalloc()
#endif
        return (p != NULL) ? p : nullptr;
    }

    static bool GetAvailableMemory(unsigned long long* mem_size)
    {
        bool rc = false;

#if defined(_MSC_VER)
        MEMORYSTATUSEX ms;
        ms.dwLength = sizeof(ms);
        rc = GlobalMemoryStatusEx(&ms);
        *mem_size = (rc) ? ms.ullAvailPhys : 0ULL;

#elif defined(__APPLE__)
        // macOS implementation using Mach APIs
        mach_port_t host_port = mach_host_self();
        mach_msg_type_number_t host_size = sizeof(vm_statistics64_data_t) / sizeof(integer_t);
        vm_size_t page_size;
        vm_statistics64_data_t vm_stat;

        if (host_page_size(host_port, &page_size) == KERN_SUCCESS &&
            host_statistics64(host_port, HOST_VM_INFO,
                              (host_info64_t)&vm_stat, &host_size) == KERN_SUCCESS)
        {
            *mem_size = static_cast<unsigned long long>(vm_stat.free_count) * page_size;
            rc = true;
        }
        else
        {
            *mem_size = 0ULL;
        }

#elif defined(__linux__)
        long pages = sysconf(_SC_AVPHYS_PAGES);
        long page_size = sysconf(_SC_PAGE_SIZE);
        rc = (pages != -1 && page_size != -1);
        *mem_size = (rc) ? (unsigned long long)pages * page_size : 0ULL;

#else
#error Unexpected target in OS::GetAvailableMemory()
#endif

        return rc;
    }


    static bool IsX32(void)
    {
        return sizeof(void*) == 4;
    }

    static bool IsX64(void)
    {
        return sizeof(void*) == 8;
    }

    static std::string GetXyyString(void)
    {
        if (OS::IsX32())
            return "X32";
        if (OS::IsX64())
            return "X64";
        return "Unknown";
    }
};
