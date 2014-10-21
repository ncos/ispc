#include <cstdio>

#define PRINT_BUF_SIZE 4096
#define uint64_t unsigned long long

static __device__ size_t d_strlen(const char *str)
{
  const char *s;

  for (s = str; *s; ++s)
    ;
  return (s - str);
}

static __device__  char* d_strncat(char *dest, const char *src, size_t n)
{
  size_t dest_len = d_strlen(dest);
  size_t i;

  for (i = 0 ; i < n && src[i] != '\0' ; i++)
    dest[dest_len + i] = src[i];
  dest[dest_len + i] = '\0';

  return dest;
}
 
#define APPEND(str)                                        \
    do {                                                   \
        int offset = bufp - &printString[0];               \
        *bufp = '\0';                                      \
        d_strncat(bufp, str, PRINT_BUF_SIZE-offset);         \
        bufp += d_strlen(str);                               \
        if (bufp >= &printString[PRINT_BUF_SIZE])          \
            goto done;                                     \
    } while (0) /* eat semicolon */


#define PRINT_SCALAR(fmt, type)                  \
    sprintf(tmpBuf, fmt, *((type *)ptr));        \
    APPEND(tmpBuf);                              \
    break

#define PRINT_VECTOR(fmt, type)                                         \
    *bufp++ = '[';                                                      \
    if (bufp == &printString[PRINT_BUF_SIZE]) break;                    \
    for (int i = 0; i < width; ++i) {                                   \
        /* only print the value if the current lane is executing */     \
        type val0 = *((type*)ptr);                                      \
        type val = val0;                                                \
        if (mask & (1ull<<i))                                           \
            sprintf(tmpBuf, fmt, val);                                  \
        else                                                            \
            sprintf(tmpBuf, "(( * )) ");                                \
        APPEND(tmpBuf);                                                 \
        *bufp++ = (i != width-1 ? ',' : ']');                           \
    }                                                                   \
    break

extern "C"
__device__ void __do_print_nvptx(const char *format, const char *types, int width, uint64_t mask,
                void **args) {
    char printString[PRINT_BUF_SIZE+1]; // +1 for trailing NUL
    char *bufp = &printString[0];
    char tmpBuf[256];
    const char  trueBuf[] = "true";
    const char falseBuf[] = "false";

    int argCount = 0;
    while (*format && bufp < &printString[PRINT_BUF_SIZE]) {
        // Format strings are just single percent signs.
        if (*format != '%') {
            *bufp++ = *format;
        }
        else {
            if (*types) {
                void *ptr = args[argCount++];
                // Based on the encoding in the types string, cast the
                // value appropriately and print it with a reasonable
                // printf() formatting string.
                switch (*types) {
                case 'b': {
                    const char *tmpBuf1 =  *((bool *)ptr) ? trueBuf : falseBuf;
                    APPEND(tmpBuf1);
                    break;
                }
                case 'B': {
                    *bufp++ = '[';
                    if (bufp == &printString[PRINT_BUF_SIZE])
                        break;
                    for (int i = 0; i < width; ++i) {
                        bool val0 = *((bool*)ptr);                                     
                        bool val = val0;                                                \
                        if (mask & (1ull << i)) {
                            const char *tmpBuf1 =  val ? trueBuf : falseBuf;
                            APPEND(tmpBuf1);
                        }
                        else
                            APPEND("_________");
                        *bufp++ = (i != width-1) ? ',' : ']';
                    }
                    break;
                }
                case 'i': PRINT_SCALAR("%d", int);
                case 'I': PRINT_VECTOR("%d", int);
                case 'u': PRINT_SCALAR("%u", unsigned int);
                case 'U': PRINT_VECTOR("%u", unsigned int);
                case 'f': PRINT_SCALAR("%f", float);
                case 'F': PRINT_VECTOR("%f", float);
                case 'l': PRINT_SCALAR("%lld", long long);
                case 'L': PRINT_VECTOR("%lld", long long);
                case 'v': PRINT_SCALAR("%llu", unsigned long long);
                case 'V': PRINT_VECTOR("%llu", unsigned long long);
                case 'd': PRINT_SCALAR("%f", double);
                case 'D': PRINT_VECTOR("%f", double);
                case 'p': PRINT_SCALAR("%p", void *);
                case 'P': PRINT_VECTOR("%p", void *);
                default:
                    APPEND("UNKNOWN TYPE ");
                    *bufp++ = *types;
                }
                ++types;
            }
        }
        ++format;
    }

 done:
    *bufp = '\n'; bufp++;
    *bufp = '\0';
}
