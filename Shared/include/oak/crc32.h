#ifndef OAK_CRC32_H_MK4EPTL2
#define OAK_CRC32_H_MK4EPTL2

#include <zlib.h>

namespace oak
{
	struct crc32_t
	{
		void process_bytes (void const* bytes, size_t len) { _checksum = ::crc32(_checksum, static_cast<Bytef const*>(bytes), static_cast<uInt>(len)); }
		uint32_t checksum () const                         { return static_cast<uint32_t>(_checksum); }

	private:
		uLong _checksum = ::crc32(0L, Z_NULL, 0);
	};

} /* oak */

#endif /* end of include guard: OAK_CRC32_H_MK4EPTL2 */
