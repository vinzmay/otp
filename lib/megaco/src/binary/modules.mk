#-*-makefile-*-   ; force emacs to enter makefile-mode

# %CopyrightBegin%
# 
# Copyright Ericsson AB 2001-2009. All Rights Reserved.
# 
# The contents of this file are subject to the Erlang Public License,
# Version 1.1, (the "License"); you may not use this file except in
# compliance with the License. You should have received a copy of the
# Erlang Public License along with this software. If not, it can be
# retrieved online at http://www.erlang.org/.
# 
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
# the License for the specific language governing rights and limitations
# under the License.
# 
# %CopyrightEnd%

MODULES = \
	megaco_binary_encoder \
	megaco_binary_encoder_lib \
	megaco_ber_encoder \
	megaco_ber_media_gateway_control_v1 \
	megaco_ber_media_gateway_control_v2 \
	megaco_ber_media_gateway_control_prev3a \
	megaco_ber_media_gateway_control_prev3b \
	megaco_ber_media_gateway_control_prev3c \
	megaco_ber_media_gateway_control_v3 \
	megaco_ber_bin_encoder \
	megaco_ber_bin_media_gateway_control_v1 \
	megaco_ber_bin_media_gateway_control_v2 \
	megaco_ber_bin_media_gateway_control_prev3a \
	megaco_ber_bin_media_gateway_control_prev3b \
	megaco_ber_bin_media_gateway_control_prev3c \
	megaco_ber_bin_media_gateway_control_v3 \
	megaco_ber_bin_drv_media_gateway_control_v1 \
	megaco_ber_bin_drv_media_gateway_control_v2 \
	megaco_ber_bin_drv_media_gateway_control_prev3a \
	megaco_ber_bin_drv_media_gateway_control_prev3b \
	megaco_ber_bin_drv_media_gateway_control_prev3c \
	megaco_ber_bin_drv_media_gateway_control_v3 \
	megaco_per_encoder \
	megaco_per_media_gateway_control_v1 \
	megaco_per_media_gateway_control_v2 \
	megaco_per_media_gateway_control_prev3a \
	megaco_per_media_gateway_control_prev3b \
	megaco_per_media_gateway_control_prev3c \
	megaco_per_media_gateway_control_v3 \
	megaco_per_bin_encoder \
	megaco_per_bin_media_gateway_control_v1 \
	megaco_per_bin_media_gateway_control_v2 \
	megaco_per_bin_media_gateway_control_prev3a \
	megaco_per_bin_media_gateway_control_prev3b \
	megaco_per_bin_media_gateway_control_prev3c \
	megaco_per_bin_media_gateway_control_v3 \
	megaco_per_bin_drv_media_gateway_control_v1 \
	megaco_per_bin_drv_media_gateway_control_v2 \
	megaco_per_bin_drv_media_gateway_control_prev3a \
	megaco_per_bin_drv_media_gateway_control_prev3b \
	megaco_per_bin_drv_media_gateway_control_prev3c \
	megaco_per_bin_drv_media_gateway_control_v3 \
	megaco_binary_name_resolver_v1 \
	megaco_binary_name_resolver_v2 \
	megaco_binary_name_resolver_prev3a \
	megaco_binary_name_resolver_prev3b \
	megaco_binary_name_resolver_prev3c \
	megaco_binary_name_resolver_v3 \
	megaco_binary_term_id \
	megaco_binary_term_id_gen \
	megaco_binary_transformer_v1 \
	megaco_binary_transformer_v2 \
	megaco_binary_transformer_prev3a  \
	megaco_binary_transformer_prev3b  \
	megaco_binary_transformer_prev3c  \
	megaco_binary_transformer_v3 

INTERNAL_HRL_FILES = 

ASN1_V1_SPEC      = MEDIA-GATEWAY-CONTROL-v1
ASN1_V2_SPEC      = MEDIA-GATEWAY-CONTROL-v2
ASN1_PREV3A_SPEC  = MEDIA-GATEWAY-CONTROL-prev3a
ASN1_PREV3B_SPEC  = MEDIA-GATEWAY-CONTROL-prev3b
ASN1_PREV3C_SPEC  = MEDIA-GATEWAY-CONTROL-prev3c
ASN1_V3_SPEC      = MEDIA-GATEWAY-CONTROL-v3

BER_ASN1_V1_SPEC         = megaco_ber_media_gateway_control_v1
BER_BIN_ASN1_V1_SPEC     = megaco_ber_bin_media_gateway_control_v1
BER_BIN_DRV_ASN1_V1_SPEC = megaco_ber_bin_drv_media_gateway_control_v1
PER_ASN1_V1_SPEC         = megaco_per_media_gateway_control_v1
PER_BIN_ASN1_V1_SPEC     = megaco_per_bin_media_gateway_control_v1
PER_BIN_DRV_ASN1_V1_SPEC = megaco_per_bin_drv_media_gateway_control_v1

BER_ASN1_V2_SPEC         = megaco_ber_media_gateway_control_v2
BER_BIN_ASN1_V2_SPEC     = megaco_ber_bin_media_gateway_control_v2
BER_BIN_DRV_ASN1_V2_SPEC = megaco_ber_bin_drv_media_gateway_control_v2
PER_ASN1_V2_SPEC         = megaco_per_media_gateway_control_v2
PER_BIN_ASN1_V2_SPEC     = megaco_per_bin_media_gateway_control_v2
PER_BIN_DRV_ASN1_V2_SPEC = megaco_per_bin_drv_media_gateway_control_v2

BER_ASN1_PREV3A_SPEC         = megaco_ber_media_gateway_control_prev3a
BER_BIN_ASN1_PREV3A_SPEC     = megaco_ber_bin_media_gateway_control_prev3a
BER_BIN_DRV_ASN1_PREV3A_SPEC = megaco_ber_bin_drv_media_gateway_control_prev3a
PER_ASN1_PREV3A_SPEC         = megaco_per_media_gateway_control_prev3a
PER_BIN_ASN1_PREV3A_SPEC     = megaco_per_bin_media_gateway_control_prev3a
PER_BIN_DRV_ASN1_PREV3A_SPEC = megaco_per_bin_drv_media_gateway_control_prev3a

BER_ASN1_PREV3B_SPEC         = megaco_ber_media_gateway_control_prev3b
BER_BIN_ASN1_PREV3B_SPEC     = megaco_ber_bin_media_gateway_control_prev3b
BER_BIN_DRV_ASN1_PREV3B_SPEC = megaco_ber_bin_drv_media_gateway_control_prev3b
PER_ASN1_PREV3B_SPEC         = megaco_per_media_gateway_control_prev3b
PER_BIN_ASN1_PREV3B_SPEC     = megaco_per_bin_media_gateway_control_prev3b
PER_BIN_DRV_ASN1_PREV3B_SPEC = megaco_per_bin_drv_media_gateway_control_prev3b

BER_ASN1_PREV3C_SPEC         = megaco_ber_media_gateway_control_prev3c
BER_BIN_ASN1_PREV3C_SPEC     = megaco_ber_bin_media_gateway_control_prev3c
BER_BIN_DRV_ASN1_PREV3C_SPEC = megaco_ber_bin_drv_media_gateway_control_prev3c
PER_ASN1_PREV3C_SPEC         = megaco_per_media_gateway_control_prev3c
PER_BIN_ASN1_PREV3C_SPEC     = megaco_per_bin_media_gateway_control_prev3c
PER_BIN_DRV_ASN1_PREV3C_SPEC = megaco_per_bin_drv_media_gateway_control_prev3c

BER_ASN1_V3_SPEC         = megaco_ber_media_gateway_control_v3
BER_BIN_ASN1_V3_SPEC     = megaco_ber_bin_media_gateway_control_v3
BER_BIN_DRV_ASN1_V3_SPEC = megaco_ber_bin_drv_media_gateway_control_v3
PER_ASN1_V3_SPEC         = megaco_per_media_gateway_control_v3
PER_BIN_ASN1_V3_SPEC     = megaco_per_bin_media_gateway_control_v3
PER_BIN_DRV_ASN1_V3_SPEC = megaco_per_bin_drv_media_gateway_control_v3

