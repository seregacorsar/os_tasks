#include <efi.h>
#include <efilib.h>
 
EFI_STATUS efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable) {
	
	InitializeLib(ImageHandle, SystemTable);
	
	EFI_STATUS status;
	
	// parameters for GetMemoryMap()
	UINTN memoryMapSize, mapKey, descriptorSize;
	EFI_MEMORY_DESCRIPTOR *memoryMap;
	UINT32 descriptorVersion;
	
	status = uefi_call_wrapper(SystemTable->BootServices->GetMemoryMap, 5, &memoryMapSize, memoryMap, &mapKey, &descriptorSize, &descriptorVersion);
	if (status != EFI_BUFFER_TOO_SMALL) {
		Print(L"error in GetMemoryMap\n");
		return EFI_SUCCESS;
	}
	
	// for AllocatePool()
	EFI_MEMORY_TYPE poolType = EfiLoaderData;
	
	status = uefi_call_wrapper(SystemTable->BootServices->AllocatePool, 3, poolType, memoryMapSize, ((void*)&memoryMap));
	if (status != EFI_SUCCESS) {
		Print(L"error in AllocatePool\n");
		return EFI_SUCCESS;
	}
	
	status = uefi_call_wrapper(SystemTable->BootServices->GetMemoryMap, 5, &memoryMapSize, memoryMap, &mapKey, &descriptorSize, &descriptorVersion);
	if (status != EFI_SUCCESS) {
		Print(L"error in GetMemoryMap\n");
		return EFI_SUCCESS;
	}
	
	return EFI_SUCCESS;
	
}