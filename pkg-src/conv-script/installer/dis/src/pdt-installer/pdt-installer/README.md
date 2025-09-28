> **Project:** pdt-installer  
> **Author:** Ali Asadi (<ali.asady@gmail.com>)  
> **Team:** Persian Developer Team  
> **License:** GPL-3.0-or-later

## 📄 `README.md` (English)

# pdt-installer

**Unified installer script** 
    [`pacstrap`](https://man.archlinux.org/man/pacstrap.8),
    [`arch-chroot`](https://man.archlinux.org/man/arch-chroot.8),  
    [`genfstab`](https://man.archlinux.org/man/genfstab.8),  
    [arch-install-scripts](https://gitlab.archlinux.org/archlinux/arch-install-scripts) 

Instead of three separate commands, you can use a single entrypoint: `pdt-installer`.

- `--base`    → acts like `pacstrap`
- `--chroot`  → acts like `arch-chroot`
- `--fstab`   → acts like `genfstab`

### Features
- 1:1 option mapping from upstream manpages
- Global flags for verbosity, dry-run, logging, version
- Clear, consistent exit codes
- Single manpage (`pdt-installer(8)`) and README
- Bash, Zsh, and Fish completions
- Basic test suite and Makefile targets

## 🔧 Requirements

As stated in [arch-install-scripts README](https://gitlab.archlinux.org/archlinux/arch-install-scripts/-/blob/master/README.rst):

- GNU coreutils (≥ 8.15)  
- util-linux (≥ 2.39)  
- awk  
- bash (≥ 4.1)  
- Upstream tools (from `arch-install-scripts`):  
  - `pacstrap`, `arch-chroot`, `genfstab`  

If any dependency is missing, `pdt-installer` exits with code **10**.

## 🚀 Installation

```bash
git clone https://github.com/yourname/pdt-installer.git
cd pdt-installer
make install
````

This installs:

* Binary: `/usr/bin/pdt-installer`
* Manpage: `/usr/share/man/man8/pdt-installer.8`
* Shell completions (bash, zsh, fish)

To uninstall:

```bash
make uninstall
```

---

## 🖥️ Usage

### Global Options

```text
-v, --verbose    Increase verbosity
-q, --quiet      Reduce output where sensible
--dry-run        Print intended actions without executing
--log <file>     Append executed commands to <file>
--version        Show version and exit
-h, --help       Show this help
```

### Subcommands (long flags only)

| Subcommand | Equivalent  | Supported Options (1:1 passthrough)       |
| ---------- | ----------- | ----------------------------------------- |
| `--base`   | pacstrap    | `-C <file> -c -D -G -i -K -M -N -P -U -h` |
| `--chroot` | arch-chroot | `-N -u <user[:group]> -r -h`              |
| `--fstab`  | genfstab    | `-L -U -t <TAG> -p -h`                    |

### Examples

* Install a base system:

  ```bash
  pdt-installer --base -U /mnt base base-devel
  ```
* Generate an fstab with UUIDs:

  ```bash
  pdt-installer --fstab -U /mnt >> /mnt/etc/fstab
  ```
* Enter the installed system:

  ```bash
  pdt-installer --chroot /mnt
  ```
* Install with host cache and new keyring:

  ```bash
  pdt-installer --base -c -K /mnt base
  ```

---

## 🔢 Exit Codes

| Code Range | Meaning                     |
| ---------- | --------------------------- |
| 0          | Success                     |
| 2          | Invalid arguments           |
| 10         | Missing dependencies        |
| 20–29      | pacstrap errors (`--base`)  |
| 30–39      | chroot errors (`--chroot`)  |
| 40–49      | genfstab errors (`--fstab`) |

---

## 📚 Documentation

* Manpage: `man 8 pdt-installer`
* Sections: NAME, SYNOPSIS, DESCRIPTION, OPTIONS, EXAMPLES, EXIT STATUS, SEE ALSO

---

## 🎯 Tests

The [`tests/`](./tests/) directory contains simple scripts that validate:

* Dry-run works for all subcommands
* Missing argument errors return the correct exit codes
* Dependency absence (simulated by hiding PATH) returns the correct exit codes

Run all tests:

```bash
make test
```

---

## 🐚 Shell Completion

* [`completions/pdt-installer.bash`](./completions/pdt-installer.bash)
* [`completions/pdt-installer.zsh`](./completions/pdt-installer.zsh)
* [`completions/pdt-installer.fish`](./completions/pdt-installer.fish)

Installed automatically via `make install`.

---

## 🛠️ Development

Repository layout:

```
pdt-installer/
├─ pdt-installer          # main script
├─ docs/                  # manpage
├─ completions/           # bash/zsh/fish completions
├─ tests/                 # basic tests
└─ Makefile
```

Lint:

```bash
make lint
```

---

## 📌 Roadmap

* [ ] Inline implementation of `pacstrap` and `genfstab` logic (no upstream dependency)
* [ ] Add `--plan` for multi-stage pipelines (base+fstab+chroot)
* [ ] GitHub Actions workflow for automated CI

------------------------------------------------------------------------------------------

## 📄 `README.md`  Persian

# pdt-installer

یک اسکریپت **یکپارچه** برای ابزارهای `pacstrap`, `arch-chroot`, و `genfstab` از بسته‌ی
[arch-install-scripts](https://gitlab.archlinux.org/archlinux/arch-install-scripts).  
این ابزار با نام واحد `pdt-installer` فراخوانی می‌شود و زیردستورات جداگانه را با
سوئیچ‌های لانگ مستقل در اختیار شما قرار می‌دهد:

- `--base`    → معادل `pacstrap`
- `--chroot`  → معادل `arch-chroot`
- `--fstab`   → معادل `genfstab`

مزایا:
- نگاشت ۱:۱ همه‌ی آپشن‌های manpageهای اصلی
- سوییچ‌های گلوبال برای verbose/quiet/dry-run/log/version
- کدهای خروج شفاف و ثابت
- مستندات کامل (manpage, README)
- کامپلشن برای bash, zsh, fish
- تست‌های خودکار (lint + dry-run)


## 🔧 Requirements

بر اساس [README upstream](https://gitlab.archlinux.org/archlinux/arch-install-scripts/-/blob/master/README.rst):

- GNU coreutils (≥ 8.15)
- util-linux (≥ 2.39)
- awk
- bash (≥ 4.1)
- ابزارهای upstream:
  - `pacstrap`, `arch-chroot`, `genfstab` (بسته‌ی `arch-install-scripts`)

اگر هرکدام موجود نباشد، `pdt-installer` با کد خروج `10` و پیام خطا خارج می‌شود.

## 🚀 Installation

```bash
git clone https://github.com/yourname/pdt-installer.git
cd pdt-installer
make install
````

نصب شامل موارد زیر است:

* باینری: `/usr/bin/pdt-installer`
* manpage: `/usr/share/man/man8/pdt-installer.8`
* فایل‌های completion در مسیرهای مناسب برای bash, zsh, fish

برای حذف:

```bash
make uninstall
```

## 🖥️ Usage

### Global Options

```text
-v, --verbose    افزایش جزئیات خروجی
-q, --quiet      خاموش کردن خروجی‌های غیرضروری
--dry-run        نمایش دستور معادل بدون اجرا
--log <file>     ذخیره‌ی دستورات اجرا شده در فایل
--version        نمایش نسخه و خروج
-h, --help       نمایش راهنما
```

### Subcommands (فقط لانگ‌فلگ)

| زیردستور   | معادل       | آپشن‌های پشتیبانی شده (۱:۱ با manpage)    |
| ---------- | ----------- | ----------------------------------------- |
| `--base`   | pacstrap    | `-C <file> -c -D -G -i -K -M -N -P -U -h` |
| `--chroot` | arch-chroot | `-N -u <user[:group]> -r -h`              |
| `--fstab`  | genfstab    | `-L -U -t <TAG> -p -h`                    |

### Examples

* نصب پایه‌ی سیستم:

  ```bash
  pdt-installer --base -U /mnt base base-devel
  ```
* تولید fstab با UUID:

  ```bash
  pdt-installer --fstab -U /mnt >> /mnt/etc/fstab
  ```
* ورود به محیط نصب‌شده:

  ```bash
  pdt-installer --chroot /mnt
  ```
* نصب با کش میزبان و keyring جدید:

  ```bash
  pdt-installer --base -c -K /mnt base
  ```

## 🔢 Exit Codes

| Code Range | Meaning                  |
| ---------- | ------------------------ |
| 0          | موفقیت                   |
| 2          | آرگومان نامعتبر          |
| 10         | پیش‌نیاز وجود ندارد      |
| 20–29      | خطای pacstrap (`--base`) |
| 30–39      | خطای chroot (`--chroot`) |
| 40–49      | خطای fstab (`--fstab`)   |


## 📚 Documentation

* manpage: `man 8 pdt-installer`
* بخش‌های اصلی man:

  * NAME
  * SYNOPSIS
  * DESCRIPTION
  * OPTIONS
  * EXAMPLES
  * EXIT STATUS
  * SEE ALSO (`pacstrap(8)`, `arch-chroot(8)`, `genfstab(8)`)


## 🎯 Tests

پوشه‌ی [`tests/`](./tests/) شامل تست‌های پایه است:

* `--base` dry-run → exit 0
* `--chroot` بدون ROOT → exit 31
* `--fstab` بدون genfstab → exit 40
* تست‌های missing-dep با تغییر PATH

اجرای تست‌ها:

```bash
make test
```

## 🐚 Shell Completion

* [`completions/pdt-installer.bash`](./completions/pdt-installer.bash)
* [`completions/pdt-installer.zsh`](./completions/pdt-installer.zsh)
* [`completions/pdt-installer.fish`](./completions/pdt-installer.fish)

این فایل‌ها به‌طور خودکار در `make install` کپی می‌شوند.


## 🛠️ Development

ساختار مخزن:

```
pdt-installer/
├─ pdt-installer          # اسکریپت اصلی
├─ docs/                  # manpage
├─ completions/           # bash/zsh/fish completion
├─ tests/                 # تست‌های پایه
└─ Makefile
```

Lint:

```bash
make lint
```

## 📌 Roadmap

* [ ] پیاده‌سازی داخلی منطق `pacstrap` و `genfstab` (بدون وابستگی به باینری‌های upstream)
* [ ] افزودن سوییچ `--plan` برای اجرای چند زیردستور پشت سر هم
* [ ] CI/CD (GitHub Actions) برای اجرای تست‌ها در کانتینر Arch

## 🔗 See Also

* [pacstrap(8)](https://man.archlinux.org/man/pacstrap.8)
* [arch-chroot(8)](https://man.archlinux.org/man/arch-chroot.8)
* [genfstab(8)](https://man.archlinux.org/man/genfstab.8)

