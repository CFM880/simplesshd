LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_CFLAGS    :=
LOCAL_MODULE    := simplesshd-jni

DROPBEAR_PATH := ../dropbear
DROPBEAR_SRCS := $(DROPBEAR_PATH)/atomicio.c \
	$(DROPBEAR_PATH)/bignum.c \
	$(DROPBEAR_PATH)/buffer.c \
	$(DROPBEAR_PATH)/circbuffer.c \
	$(DROPBEAR_PATH)/common-algo.c \
	$(DROPBEAR_PATH)/common-channel.c \
	$(DROPBEAR_PATH)/common-chansession.c \
	$(DROPBEAR_PATH)/common-kex.c \
	$(DROPBEAR_PATH)/common-runopts.c \
	$(DROPBEAR_PATH)/common-session.c \
	$(DROPBEAR_PATH)/compat.c \
	$(DROPBEAR_PATH)/crypto_desc.c \
	$(DROPBEAR_PATH)/curve25519-donna.c \
	$(DROPBEAR_PATH)/dbrandom.c \
	$(DROPBEAR_PATH)/dbutil.c \
	$(DROPBEAR_PATH)/dss.c \
	$(DROPBEAR_PATH)/ecc.c \
	$(DROPBEAR_PATH)/ecdsa.c \
	$(DROPBEAR_PATH)/fake-rfc2553.c \
	$(DROPBEAR_PATH)/gendss.c \
	$(DROPBEAR_PATH)/genrsa.c \
	$(DROPBEAR_PATH)/gensignkey.c \
	$(DROPBEAR_PATH)/keyimport.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/aes/aes.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/anubis.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/blowfish.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/cast5.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/des.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/kasumi.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/khazad.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/kseed.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/noekeon.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/rc2.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/rc5.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/rc6.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/safer/safer.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/safer/safer_tab.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/safer/saferp.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/skipjack.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/twofish/twofish.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/ciphers/xtea.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ccm/ccm_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ccm/ccm_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/eax/eax_addheader.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/eax/eax_decrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/eax/eax_decrypt_verify_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/eax/eax_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/eax/eax_encrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/eax/eax_encrypt_authenticate_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/eax/eax_init.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/eax/eax_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/gcm/gcm_add_aad.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/gcm/gcm_add_iv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/gcm/gcm_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/gcm/gcm_gf_mult.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/gcm/gcm_init.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/gcm/gcm_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/gcm/gcm_mult_h.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/gcm/gcm_process.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/gcm/gcm_reset.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/gcm/gcm_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ocb/ocb_decrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ocb/ocb_decrypt_verify_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ocb/ocb_done_decrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ocb/ocb_done_encrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ocb/ocb_encrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ocb/ocb_encrypt_authenticate_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ocb/ocb_init.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ocb/ocb_ntz.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ocb/ocb_shift_xor.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ocb/ocb_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/encauth/ocb/s_ocb_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/chc/chc.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/helper/hash_file.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/helper/hash_filehandle.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/helper/hash_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/helper/hash_memory_multi.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/md2.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/md4.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/md5.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/rmd128.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/rmd160.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/rmd256.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/rmd320.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/sha1.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/sha2/sha256.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/sha2/sha512.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/tiger.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/hashes/whirl/whirl.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/f9/f9_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/f9/f9_file.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/f9/f9_init.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/f9/f9_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/f9/f9_memory_multi.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/f9/f9_process.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/f9/f9_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/hmac/hmac_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/hmac/hmac_file.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/hmac/hmac_init.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/hmac/hmac_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/hmac/hmac_memory_multi.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/hmac/hmac_process.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/hmac/hmac_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/omac/omac_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/omac/omac_file.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/omac/omac_init.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/omac/omac_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/omac/omac_memory_multi.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/omac/omac_process.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/omac/omac_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/pelican/pelican.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/pelican/pelican_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/pelican/pelican_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/pmac/pmac_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/pmac/pmac_file.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/pmac/pmac_init.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/pmac/pmac_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/pmac/pmac_memory_multi.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/pmac/pmac_ntz.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/pmac/pmac_process.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/pmac/pmac_shift_xor.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/pmac/pmac_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/xcbc/xcbc_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/xcbc/xcbc_file.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/xcbc/xcbc_init.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/xcbc/xcbc_memory.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/xcbc/xcbc_memory_multi.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/xcbc/xcbc_process.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/mac/xcbc/xcbc_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/math/fp/ltc_ecc_fp_mulmod.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/math/gmp_desc.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/math/ltm_desc.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/math/multi.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/math/rand_prime.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/math/tfm_desc.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/base64/base64_decode.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/base64/base64_encode.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/burn_stack.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_argchk.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_cipher_descriptor.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_cipher_is_valid.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_find_cipher.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_find_cipher_any.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_find_cipher_id.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_find_hash.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_find_hash_any.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_find_hash_id.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_find_hash_oid.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_find_prng.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_fsa.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_hash_descriptor.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_hash_is_valid.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_ltc_mp_descriptor.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_prng_descriptor.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_prng_is_valid.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_register_cipher.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_register_hash.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_register_prng.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_unregister_cipher.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_unregister_hash.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/crypt/crypt_unregister_prng.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/error_to_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/pkcs5/pkcs_5_1.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/pkcs5/pkcs_5_2.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/misc/zeromem.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/cbc/cbc_decrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/cbc/cbc_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/cbc/cbc_encrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/cbc/cbc_getiv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/cbc/cbc_setiv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/cbc/cbc_start.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/cfb/cfb_decrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/cfb/cfb_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/cfb/cfb_encrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/cfb/cfb_getiv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/cfb/cfb_setiv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/cfb/cfb_start.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ctr/ctr_decrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ctr/ctr_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ctr/ctr_encrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ctr/ctr_getiv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ctr/ctr_setiv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ctr/ctr_start.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ctr/ctr_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ecb/ecb_decrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ecb/ecb_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ecb/ecb_encrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ecb/ecb_start.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/f8/f8_decrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/f8/f8_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/f8/f8_encrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/f8/f8_getiv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/f8/f8_setiv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/f8/f8_start.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/f8/f8_test_mode.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/lrw/lrw_decrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/lrw/lrw_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/lrw/lrw_encrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/lrw/lrw_getiv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/lrw/lrw_process.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/lrw/lrw_setiv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/lrw/lrw_start.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/lrw/lrw_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ofb/ofb_decrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ofb/ofb_done.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ofb/ofb_encrypt.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ofb/ofb_getiv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ofb/ofb_setiv.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/modes/ofb/ofb_start.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/bit/der_decode_bit_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/bit/der_encode_bit_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/bit/der_length_bit_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/boolean/der_decode_boolean.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/boolean/der_encode_boolean.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/boolean/der_length_boolean.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/choice/der_decode_choice.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/ia5/der_decode_ia5_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/ia5/der_encode_ia5_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/ia5/der_length_ia5_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/integer/der_decode_integer.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/integer/der_encode_integer.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/integer/der_length_integer.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/object_identifier/der_decode_object_identifier.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/object_identifier/der_encode_object_identifier.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/object_identifier/der_length_object_identifier.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/octet/der_decode_octet_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/octet/der_encode_octet_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/octet/der_length_octet_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/printable_string/der_decode_printable_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/printable_string/der_encode_printable_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/printable_string/der_length_printable_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/sequence/der_decode_sequence_ex.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/sequence/der_decode_sequence_flexi.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/sequence/der_decode_sequence_multi.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/sequence/der_encode_sequence_ex.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/sequence/der_encode_sequence_multi.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/sequence/der_length_sequence.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/sequence/der_sequence_free.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/set/der_encode_set.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/set/der_encode_setof.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/short_integer/der_decode_short_integer.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/short_integer/der_encode_short_integer.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/short_integer/der_length_short_integer.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/utctime/der_decode_utctime.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/utctime/der_encode_utctime.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/utctime/der_length_utctime.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/utf8/der_decode_utf8_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/utf8/der_encode_utf8_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/asn1/der/utf8/der_length_utf8_string.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/dsa/dsa_decrypt_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/dsa/dsa_encrypt_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/dsa/dsa_export.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/dsa/dsa_free.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/dsa/dsa_import.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/dsa/dsa_make_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/dsa/dsa_shared_secret.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/dsa/dsa_sign_hash.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/dsa/dsa_verify_hash.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/dsa/dsa_verify_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_ansi_x963_export.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_ansi_x963_import.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_decrypt_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_encrypt_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_export.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_free.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_get_size.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_import.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_make_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_shared_secret.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_sign_hash.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_sizes.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_test.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ecc_verify_hash.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ltc_ecc_is_valid_idx.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ltc_ecc_map.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ltc_ecc_mul2add.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ltc_ecc_mulmod.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ltc_ecc_mulmod_timing.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ltc_ecc_points.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ltc_ecc_projective_add_point.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/ecc/ltc_ecc_projective_dbl_point.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/katja/katja_decrypt_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/katja/katja_encrypt_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/katja/katja_export.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/katja/katja_exptmod.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/katja/katja_free.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/katja/katja_import.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/katja/katja_make_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/pkcs1/pkcs_1_i2osp.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/pkcs1/pkcs_1_mgf1.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/pkcs1/pkcs_1_oaep_decode.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/pkcs1/pkcs_1_oaep_encode.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/pkcs1/pkcs_1_os2ip.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/pkcs1/pkcs_1_pss_decode.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/pkcs1/pkcs_1_pss_encode.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/pkcs1/pkcs_1_v1_5_decode.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/pkcs1/pkcs_1_v1_5_encode.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/rsa/rsa_decrypt_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/rsa/rsa_encrypt_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/rsa/rsa_export.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/rsa/rsa_exptmod.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/rsa/rsa_free.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/rsa/rsa_import.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/rsa/rsa_make_key.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/rsa/rsa_sign_hash.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/pk/rsa/rsa_verify_hash.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/prngs/fortuna.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/prngs/rc4.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/prngs/rng_get_bytes.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/prngs/rng_make_prng.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/prngs/sober128.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/prngs/sprng.c \
	$(DROPBEAR_PATH)/libtomcrypt/src/prngs/yarrow.c \
	$(DROPBEAR_PATH)/libtommath/bn_error.c \
	$(DROPBEAR_PATH)/libtommath/bn_fast_mp_invmod.c \
	$(DROPBEAR_PATH)/libtommath/bn_fast_mp_montgomery_reduce.c \
	$(DROPBEAR_PATH)/libtommath/bn_fast_s_mp_mul_digs.c \
	$(DROPBEAR_PATH)/libtommath/bn_fast_s_mp_mul_high_digs.c \
	$(DROPBEAR_PATH)/libtommath/bn_fast_s_mp_sqr.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_2expt.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_abs.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_add.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_add_d.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_addmod.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_and.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_clamp.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_clear.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_clear_multi.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_cmp.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_cmp_d.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_cmp_mag.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_cnt_lsb.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_copy.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_count_bits.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_div.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_div_2.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_div_2d.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_div_3.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_div_d.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_dr_is_modulus.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_dr_reduce.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_dr_setup.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_exch.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_expt_d.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_exptmod.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_exptmod_fast.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_exteuclid.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_fread.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_fwrite.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_gcd.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_get_int.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_grow.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_init.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_init_copy.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_init_multi.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_init_set.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_init_set_int.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_init_size.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_invmod.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_invmod_slow.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_is_square.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_jacobi.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_karatsuba_mul.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_karatsuba_sqr.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_lcm.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_lshd.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_mod.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_mod_2d.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_mod_d.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_montgomery_calc_normalization.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_montgomery_reduce.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_montgomery_setup.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_mul.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_mul_2.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_mul_2d.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_mul_d.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_mulmod.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_n_root.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_neg.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_or.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_prime_fermat.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_prime_is_divisible.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_prime_is_prime.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_prime_miller_rabin.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_prime_next_prime.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_prime_rabin_miller_trials.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_prime_random_ex.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_radix_size.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_radix_smap.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_rand.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_read_radix.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_read_signed_bin.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_read_unsigned_bin.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_reduce.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_reduce_2k.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_reduce_2k_l.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_reduce_2k_setup.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_reduce_2k_setup_l.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_reduce_is_2k.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_reduce_is_2k_l.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_reduce_setup.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_rshd.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_set.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_set_int.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_shrink.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_signed_bin_size.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_sqr.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_sqrmod.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_sqrt.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_sub.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_sub_d.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_submod.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_to_signed_bin.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_to_signed_bin_n.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_to_unsigned_bin.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_to_unsigned_bin_n.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_toom_mul.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_toom_sqr.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_toradix.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_toradix_n.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_unsigned_bin_size.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_xor.c \
	$(DROPBEAR_PATH)/libtommath/bn_mp_zero.c \
	$(DROPBEAR_PATH)/libtommath/bn_prime_tab.c \
	$(DROPBEAR_PATH)/libtommath/bn_reverse.c \
	$(DROPBEAR_PATH)/libtommath/bn_s_mp_add.c \
	$(DROPBEAR_PATH)/libtommath/bn_s_mp_exptmod.c \
	$(DROPBEAR_PATH)/libtommath/bn_s_mp_mul_digs.c \
	$(DROPBEAR_PATH)/libtommath/bn_s_mp_mul_high_digs.c \
	$(DROPBEAR_PATH)/libtommath/bn_s_mp_sqr.c \
	$(DROPBEAR_PATH)/libtommath/bn_s_mp_sub.c \
	$(DROPBEAR_PATH)/libtommath/bncore.c \
	$(DROPBEAR_PATH)/list.c \
	$(DROPBEAR_PATH)/listener.c \
	$(DROPBEAR_PATH)/loginrec.c \
	$(DROPBEAR_PATH)/ltc_prng.c \
	$(DROPBEAR_PATH)/packet.c \
	$(DROPBEAR_PATH)/process-packet.c \
	$(DROPBEAR_PATH)/progressmeter.c \
	$(DROPBEAR_PATH)/queue.c \
	$(DROPBEAR_PATH)/rsa.c \
	$(DROPBEAR_PATH)/signkey.c \
	$(DROPBEAR_PATH)/sshpty.c \
	$(DROPBEAR_PATH)/svr-agentfwd.c \
	$(DROPBEAR_PATH)/svr-auth.c \
	$(DROPBEAR_PATH)/svr-authpasswd.c \
	$(DROPBEAR_PATH)/svr-authpubkey.c \
	$(DROPBEAR_PATH)/svr-authpubkeyoptions.c \
	$(DROPBEAR_PATH)/svr-chansession.c \
	$(DROPBEAR_PATH)/svr-kex.c \
	$(DROPBEAR_PATH)/svr-main.c \
	$(DROPBEAR_PATH)/svr-runopts.c \
	$(DROPBEAR_PATH)/svr-service.c \
	$(DROPBEAR_PATH)/svr-session.c \
	$(DROPBEAR_PATH)/svr-tcpfwd.c \
	$(DROPBEAR_PATH)/svr-x11fwd.c \
	$(DROPBEAR_PATH)/tcp-accept.c \
	$(DROPBEAR_PATH)/termcodes.c

LOCAL_SRC_FILES := interface.c $(DROPBEAR_SRCS)
LOCAL_C_INCLUDES:= dropbear dropbear/libtomcrypt/src/headers dropbear/libtommath
LOCAL_LDLIBS    := -lz

include $(BUILD_SHARED_LIBRARY)


# build separate scp executable

include $(CLEAR_VARS)

LOCAL_CFLAGS    := -Wall
LOCAL_MODULE    := scp

DROPBEAR_PATH := ../dropbear
LOCAL_SRC_FILES := $(DROPBEAR_PATH)/scp.c \
	$(DROPBEAR_PATH)/scpmisc.c \
	$(DROPBEAR_PATH)/atomicio.c
LOCAL_C_INCLUDES:= dropbear dropbear/libtomcrypt/src/headers dropbear/libtommath
# LOCAL_LDLIBS    :=
LOCAL_LDFLAGS   := -static

include $(BUILD_EXECUTABLE)


# build separate sftp executable

include $(CLEAR_VARS)

LOCAL_CFLAGS    := -Wall
LOCAL_MODULE    := sftp-server

OPENSSH_PATH := ../openssh
LOCAL_SRC_FILES := $(OPENSSH_PATH)/sftp-server-main.c \
	$(OPENSSH_PATH)/sftp-server.c \
	$(OPENSSH_PATH)/sftp-common.c \
	$(OPENSSH_PATH)/buffer.c \
	$(OPENSSH_PATH)/bufaux.c \
	$(OPENSSH_PATH)/sshbuf.c \
	$(OPENSSH_PATH)/sshbuf-getput-basic.c \
	$(OPENSSH_PATH)/ssherr.c \
	$(OPENSSH_PATH)/misc.c \
	$(OPENSSH_PATH)/match.c \
	$(OPENSSH_PATH)/xmalloc.c \
	$(OPENSSH_PATH)/openbsd-compat/fmt_scaled.c \
	$(OPENSSH_PATH)/openbsd-compat/getopt_long.c \
	$(OPENSSH_PATH)/openbsd-compat/pwcache.c \
	$(OPENSSH_PATH)/openbsd-compat/strmode.c
LOCAL_C_INCLUDES:= openssh
# LOCAL_LDLIBS    :=
LOCAL_LDFLAGS   := -static

include $(BUILD_EXECUTABLE)


# build separate rsync executable

include $(CLEAR_VARS)

LOCAL_CFLAGS    := -Wall
LOCAL_MODULE    := rsync

RSYNC_PATH := ../rsync
LOCAL_SRC_FILES := $(RSYNC_PATH)/flist.c \
	$(RSYNC_PATH)/rsync.c \
	$(RSYNC_PATH)/generator.c \
	$(RSYNC_PATH)/receiver.c \
	$(RSYNC_PATH)/cleanup.c \
	$(RSYNC_PATH)/sender.c \
	$(RSYNC_PATH)/exclude.c \
	$(RSYNC_PATH)/util.c \
	$(RSYNC_PATH)/util2.c \
	$(RSYNC_PATH)/main.c \
	$(RSYNC_PATH)/checksum.c \
	$(RSYNC_PATH)/match.c \
	$(RSYNC_PATH)/syscall.c \
	$(RSYNC_PATH)/log.c \
	$(RSYNC_PATH)/backup.c \
	$(RSYNC_PATH)/delete.c \
	$(RSYNC_PATH)/options.c \
	$(RSYNC_PATH)/io.c \
	$(RSYNC_PATH)/compat.c \
	$(RSYNC_PATH)/hlink.c \
	$(RSYNC_PATH)/token.c \
	$(RSYNC_PATH)/uidlist.c \
	$(RSYNC_PATH)/socket.c \
	$(RSYNC_PATH)/hashtable.c \
	$(RSYNC_PATH)/fileio.c \
	$(RSYNC_PATH)/batch.c \
	$(RSYNC_PATH)/clientname.c \
	$(RSYNC_PATH)/chmod.c \
	$(RSYNC_PATH)/acls.c \
	$(RSYNC_PATH)/xattrs.c \
	$(RSYNC_PATH)/progress.c \
	$(RSYNC_PATH)/pipe.c \
	$(RSYNC_PATH)/params.c \
	$(RSYNC_PATH)/loadparm.c \
	$(RSYNC_PATH)/clientserver.c \
	$(RSYNC_PATH)/access.c \
	$(RSYNC_PATH)/connection.c \
	$(RSYNC_PATH)/authenticate.c \
	$(RSYNC_PATH)/lib/wildmatch.c \
	$(RSYNC_PATH)/lib/compat.c \
	$(RSYNC_PATH)/lib/snprintf.c \
	$(RSYNC_PATH)/lib/mdfour.c \
	$(RSYNC_PATH)/lib/md5.c \
	$(RSYNC_PATH)/lib/permstring.c \
	$(RSYNC_PATH)/lib/pool_alloc.c \
	$(RSYNC_PATH)/lib/sysacls.c \
	$(RSYNC_PATH)/lib/sysxattrs.c \
	$(RSYNC_PATH)/lib/getpass.c \
	$(RSYNC_PATH)/popt/findme.c \
	$(RSYNC_PATH)/popt/popt.c \
	$(RSYNC_PATH)/popt/poptconfig.c \
	$(RSYNC_PATH)/popt/popthelp.c \
	$(RSYNC_PATH)/popt/poptparse.c \
	$(RSYNC_PATH)/zlib/deflate.c \
	$(RSYNC_PATH)/zlib/inffast.c \
	$(RSYNC_PATH)/zlib/inflate.c \
	$(RSYNC_PATH)/zlib/inftrees.c \
	$(RSYNC_PATH)/zlib/trees.c \
	$(RSYNC_PATH)/zlib/zutil.c \
	$(RSYNC_PATH)/zlib/adler32.c \
	$(RSYNC_PATH)/zlib/compress.c \
	$(RSYNC_PATH)/zlib/crc32.c

LOCAL_C_INCLUDES:= rsync rsync/popt rsync/zlib
LOCAL_LDLIBS    :=
LOCAL_LDFLAGS   := -static

include $(BUILD_EXECUTABLE)


# build separate sftp executable

include $(CLEAR_VARS)

LOCAL_CFLAGS    := -Wall
LOCAL_MODULE    := buffersu

LOCAL_SRC_FILES := buffersu.c
# LOCAL_LDLIBS    :=
LOCAL_LDFLAGS   := -static

include $(BUILD_EXECUTABLE)
